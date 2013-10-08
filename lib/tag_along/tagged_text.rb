class TagAlong

  class TaggedText
    CHR = { '<' => 60, '>' => 62 }
    SPACES = { 9 => true, 10 => true, 11 => true, 12 => true,
               13 => true, 32 => true, 133 => true, 160 => true,
               5760 => true, 6158 => true, 8192 => true,
               8193 => true, 8194 => true, 8195 => true,
               8196 => true, 8197 => true, 8198 => true,
               8199 => true, 8200 => true, 8201 => true,
               8202 => true, 8232 => true, 8233 => true,
               8239 => true, 8287 => true, 12288 => true }

    attr_reader :tagged_text, :offsets

    def initialize(tagged_text, opts = {})
      @normalize_spaces = true if opts[:normalize_spaces]
      @tagged_text = tagged_text
      @inside_tag = false
      @inside_space = false
      @offsets  = []
      @text = []
      @text_offset = 0
      @current_offset = { type: :text, start: 0, end: nil,
                          text_start: 0, text_end: nil }
      process_tagged_text
    end

    def plain_text
      @text.pack('U*')
    end

    def adjust_offsets(plain_text_offsets)
      plain_text_offsets = plain_text_offsets.is_a?(Offsets) ?
                            plain_text_offsets :
                            Offsets.new(plain_text_offsets)
      adjusted_offsets = TagAlong::Offsets.new([])
      @offsets.each do |offset|
        next if offset[:type] == :tag
        process_offset(plain_text_offsets, offset, adjusted_offsets)
        break if plain_text_offsets.empty?
      end
      adjusted_offsets
    end


    private

    def process_offset(plain_text_offsets, offset, adjusted_offsets)
      o  = plain_text_offsets[0]

      return if o.offset_start > offset[:text_start]
      unless o.adj_start
        delta = o.offset_start - offset[:text_start]
        o.adj_start = offset[:start] + delta
      end

      if o.offset_end <= offset[:text_end]
        delta = o.offset_end - offset[:text_end]
        o = plain_text_offsets.shift
        o.offset_start = o.delete_field(:adj_start)
        o.offset_end = offset[:end] + delta
        adjusted_offsets << o
      end
    end

    def process_tagged_text
      opts = { count: 0, chr: nil }
      while opts[:chr] = tagged_text_ary.shift
        @inside_tag ?  process_inside_tag(opts) : process_outside_tag(opts)
        opts[:count] += 1
      end
    end

    def tagged_text_ary
      @tagged_text_ary ||= @tagged_text.unpack('U*')
    end

    def process_outside_tag(opts)
      if opts[:chr] == CHR['<']
        @inside_tag = true
        if opts[:count] > 0
          @current_offset[:end] = opts[:count] - 1
          @current_offset[:text_end] = @text_offset - 1
          @offsets << @current_offset
        end
        @current_offset = { type: :tag, start: opts[:count], end: nil }
      else
        process_text(opts)
      end
    end

    def process_inside_tag(opts)
      if opts[:chr] == CHR['>']
        @inside_tag = false
        @current_offset[:end] = opts[:count]
        @offsets << @current_offset
        @current_offset = { type: :text, start: opts[:count] + 1, end: nil,
                            text_start: @text_offset, text_end: nil }
      end
    end

    def process_text(opts)
      if @normalize_spaces
        process_normalized_spaces_text(opts)
      else
        add_to_text(opts)
      end
    end

    def add_to_text(opts)
      @text_offset += 1
      @text << opts[:chr]
    end

    def process_normalized_spaces_text(opts)
      @inside_space ? process_inside_space(opts) : process_outside_space(opts)
    end

    def process_inside_space(opts)
      #TODO
    end

    def process_outside_space(opts)
      #TODO
    end
  end
end

