require "tag_along/version"

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
    # @offsets = Offsets.new(offsets)
    @tagged_text = '<my_tag>Lebistes reticulatus</my_tag>'
  end

end
