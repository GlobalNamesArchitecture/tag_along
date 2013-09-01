require "tag_along/version"

class TagAlong

  def self.version
    VERSION
  end

  def initialize(text)
    @text = text
  end

  def tag(open_tag, close_tag, offsets)
    @offsets = Offsets.new(offsets)
  end

end

