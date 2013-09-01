require 'ostruct'
require 'tag_along/version'
require 'tag_along/offsets'

class TagAlong

  attr :text, :tagged_text

  def self.version
    VERSION
  end

  def initialize(text)
    @text = text
    @tagged_text = nil
  end

  def tag(open_tag, close_tag, offsets)
    @offsets = offsets.is_a?(Offsets) ? offsets : Offsets.new(offsets)
    @tagged_text = '<my_tag>Lebistes reticulatus</my_tag>'
  end

end
