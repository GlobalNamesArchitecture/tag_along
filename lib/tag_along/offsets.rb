class TagAlong

  class Offsets
    include Enumerable

    def initialize(offsets, opts = {})

      @offsets      = offsets
      @offset_start = (opts[:offset_start] || 'offset_start').to_sym
      @offset_end   = (opts[:offset_end]   || 'offset_end').to_sym
      @data_start   = (opts[:data_start]   || 'data_start').to_sym
      @data_end     = (opts[:data_end]     || 'data_end').to_sym

      item = @offsets.first
      if item.is_a?(Array)
        process_array
      elsif item.is_a?(Hash)
        process_hash
      else
        process_obj
      end
      @offsets.sort_by!(&:offset_start)
    end

    def each(&block)
      @offsets.each do |o|
        block.call(o)
      end
    end

    def [](num)
      @offsets[num]
    end

    def shift
      @offsets.shift
    end

    def empty?
      @offsets.empty?
    end

    def << offset
      unless offset.respond_to?(:offset_start) && offset.respond_to?(:offset_end)
        raise TypeError.new('Object does not match Offset signature')
      end
      @offsets << offset
    end

    private

    def process_array
      @offsets = @offsets.map do |o|
        offset_start = o[0]
        offset_end = o[1]
        data_start = o[2]
        data_end = o[3]
        instantiate(offset_start, offset_end, data_start, data_end)
      end
    end

    def process_hash
      @offsets.each { |h| symbolize_keys(h) }
      @offsets = @offsets.map do |h|
        instantiate(h[@offset_start],
                    h[@offset_end],
                    h[@data_start],
                    h[@data_end])
      end
    end

    def process_obj
      @offsets = @offsets.map do |obj|
        offset_start = obj.send(@offset_start)
        offset_end = obj.send(@offset_end)
        data_start = obj.send(@data_start)
        data_end = obj.send(@data_end)
        instantiate(offset_start, offset_end, data_start, data_end)
      end
    end

    def instantiate(offset_start, offset_end, data_start = nil, data_end = nil)
      data_start = data_to_ary(data_start)
      data_end = data_to_ary(data_end)
      OpenStruct.new(offset_start: to_int(offset_start),
                     offset_end:   to_int(offset_end),
                     data_start:   data_start,
                     data_end:     data_end)
    end

    def data_to_ary(data)
      return data unless data
      data.is_a?(Array) ? data : [data]
    end

    def to_int(val)
      int = val.to_i
      raise TypeError.new('Offsets must be integers') if int.to_s != val.to_s
      int
    end

    def symbolize_keys(a_hash)
      a_hash.keys.each do |key|
        a_hash[(key.to_sym rescue key) || key] = a_hash.delete(key)
      end
    end

  end

end
