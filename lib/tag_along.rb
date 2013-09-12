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
    open_tag_subs = open_tag.scan(/%s/).size
    close_tag_subs = close_tag.scan(/%s/).size
    @tagged_text = @split_text.inject([]) do |res, t|
      if t[:tagged]
        ot = dyn_tag(open_tag, t[:data_start], open_tag_subs) 
        ct = dyn_tag(close_tag, t[:data_end], close_tag_subs)
        [ot, t[:text], ct].each { |text| res << text }
      else
        res << t[:text]
      end
      res
    end.join('')
  end

  private

  def dyn_tag(tag, data, subs_num)
    return tag if subs_num == 0
    tag % data
  end

  def split_text
    return  if @split_text
    
    text_ary = @text.unpack('U*')
    cursor = 0
    fragment = []
    res = []
    @offsets.each do |item|
      chars_num = item.offset_start - cursor
      chars_num.times { fragment << text_ary.shift }
      res << { tagged: false, text: fragment }
      fragment = []
      cursor = item.offset_start
      chars_num = item.offset_end + 1 - cursor
      chars_num.times { fragment << text_ary.shift }
      res << { tagged:     true, 
               text:       fragment, 
               data_start: item.data_start,
               data_end:   item.data_end}
      fragment = []
      cursor = item.offset_end + 1
    end
    
    unless text_ary.empty?
      res << { tagged: false,
               text: text_ary } 
    end
             

    res.each do |r|
      r[:text] = r[:text].pack('U*')
    end
    @split_text = res
  end

end
