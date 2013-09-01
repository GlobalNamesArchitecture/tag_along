class TagAlong

  class Offsets
    include Enumerable

    def initialize(offsets, opts = {})

      @offsets = offsets
      @offset_start = opts[:offset_start] || 'offset_start'
      @offset_end   = opts[:offset_end]   || 'offset_end'
      @item_sring   = opts[:item_string]  || 'item_string'
      
      item = @offsets.first
      if item.is_a?(Array)
        process_array
      elsif item.is_a?(Hash)
        process_hash
      else 
        process_obj
      end
    end

    def each(&block)
      @offsets.each do |o|
        block.call(o)
      end
    end

    private

    def process_array
      @offsets = @offsets.map do |o|
        instantiate(o[0], o[1], o[3])
      end
    end

    def process_hash
    end

    def process_obj
    end
    
    def instantiate(offset_start, offset_end, item_string)
      OpenStruct.new(offset_start: offset_start,
                     offset_end:   offset_end,
                     item_string:  item_string)
    end
  end

end
