require 'json'
require 'ostruct'
require_relative '../lib/tag_along'

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
                     offset_start: h[:offsetStart],
                     offset_end: h[:offsetEnd])
    end
    offset_ary = offset_obj.map { |h| [h.offset_start, h.offset_end] }
    [text, offset_hash, offset_ary, offset_hash, offset_obj]
  end
end

unless defined?(SPEC_VARS)
  FILES_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'files'))
  CONTENT, OFFSET_ARY, OFFSET_HASH, OFFSET_OBJ = 
    TagAlongSpec.process_spec_data(FILES_DIR)
  SPEC_VARS = true
end