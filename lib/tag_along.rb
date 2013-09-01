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
    @tagged_text = @split_text.inject([]) do |res, t|
      if t[:tagged]
        [open_tag, t[:text], close_tag].each { |text| res << text }
      else
        res << t[:text]
      end
      res
    end.join('')
  end

  private

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
      res << { tagged: true, text: fragment }
      fragment = []
      cursor = item.offset_end + 1
    end

    res.each do |r|
      r[:text] = r[:text].pack('U*')
    end
    @split_text = res
  end

end
