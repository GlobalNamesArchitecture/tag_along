require 'coveralls'
Coveralls.wear!

require 'json'
require 'ostruct'
require 'tag_along'

RSpec.configure do |c|
  c.mock_with :rr
end

module TagAlongSpec
  def self.process_spec_data(dir)
    data = open(File.join(dir, 'spec_data.json')).read
    data = JSON.parse(data, symbolize_names: true)
    text = data[:content]
    offset_hash = data[:names]
    offset_obj = offset_hash.map do |h| 
      OpenStruct.new(name: h[:verbatim],
                     start: h[:offsetStart],
                     end: h[:offsetEnd])
    end
    offset_ary = offset_obj.map { |h| [h.start, h.end] }
    [text, offset_ary, offset_hash, offset_obj]
  end
end

unless defined?(SPEC_VARS)
  FILES_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'files'))
  TEXT, OFFSETS_ARY, OFFSETS_HASH, OFFSETS_OBJ = 
    TagAlongSpec.process_spec_data(FILES_DIR)
  SPEC_VARS = true
end
