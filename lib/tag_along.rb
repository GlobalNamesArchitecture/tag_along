require 'ostruct'
require 'tag_along/version'
require 'tag_along/offsets'

class TagAlong

  attr :text, :tagged_text

  def self.version
    VERSION
  end

  def initialize(text, offsets)
    @offsets = offsets.is_a?(Offsets) ? offsets : Offsets.new(offsets)
    @text = text
    @split_text = nil
    @tagged_text = nil
    split_text
  end

  def tag(open_tag, close_tag)
    opts = {
      open_tag: open_tag,
      close_tag: close_tag,
      open_tag_subs: open_tag.scan(/%s/).size,
      close_tag_subs: close_tag.scan(/%s/).size,
    }
    @tagged_text = @split_text.inject([]) do |res, t|
      process_tag(res, t, opts)
      res
    end.join('')
  end

  private

  def process_tag(text_ary, text_fragment, opts)
    t = text_fragment
    if t[:tagged]
      ot = dyn_tag(opts[:open_tag], t[:data_start], opts[:open_tag_subs]) 
      ct = dyn_tag(opts[:close_tag], t[:data_end], opts[:close_tag_subs])
      [ot, t[:text], ct].each { |text| text_ary << text }
    else
      text_ary << t[:text]
    end
  end

  def dyn_tag(tag, data, subs_num)
    return tag if subs_num == 0
    tag % data
  end
  
  def process_tagged_item(res, item, opts)
    fragment = []
    chars_num = item.offset_start - opts[:cursor]
    chars_num.times { fragment << opts[:text_ary].shift }
    res << { tagged: false, text: fragment }
    fragment = []
    opts[:cursor] = item.offset_start
    chars_num = item.offset_end + 1 - opts[:cursor]
    chars_num.times { fragment << opts[:text_ary].shift }
    res << { tagged:     true, 
             text:       fragment, 
             data_start: item.data_start,
             data_end:   item.data_end}
    opts[:cursor] = item.offset_end + 1
  end

  def split_text
    @split_text ||= create_split_text
  end

  def create_split_text
    opts = { text_ary: @text.unpack('U*'), cursor: 0 }

    @split_text = @offsets.inject([]) do |res, item|
      process_tagged_item(res, item, opts)
      res
    end
    @split_text << { tagged: false, text: opts[:text_ary] }
    @split_text.each do |r|
      r[:text] = r[:text].pack('U*')
    end
  end

end
