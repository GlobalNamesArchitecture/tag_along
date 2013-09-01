class TagAlong

  class Offsets
    include Enumerable

    def initialize(offsets, opts = {})

      @offsets      = offsets
      @offset_start = (opts[:offset_start] || 'offset_start').to_sym
      @offset_end   = (opts[:offset_end]   || 'offset_end').to_sym
      @item_string   = (opts[:item_string]  || 'item_string').to_sym
      
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
        offset_start = o[0]
        offset_end = o[1]
        item_string = o[2]
        instantiate(offset_start, offset_end, item_string) 
      end
    end

    def process_hash
      @offsets.each { |h| symbolize_keys(h) }
      @offsets = @offsets.map do |o|
        instantiate(o[@offset_start], o[@offset_end], o[@item_string]) 
      end
    end

    def process_obj
      @offsets = @offsets.map do |o|
        instantiate(o.send(@offset_start), 
                    o.send(@offset_end), 
                    o.send(@item_string)) 
      end
    end
    
    def instantiate(offset_start, offset_end, item_string)
      OpenStruct.new(offset_start: to_int(offset_start),
                     offset_end:   to_int(offset_end),
                     item_string:  item_string)
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
