# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tag_along/version'

Gem::Specification.new do |sp|
  sp.name          = 'tag_along'
  sp.version       = TagAlong::VERSION
  sp.authors       = ['Dmitry Mozzherin']
  sp.email         = ['dmozzherin@gmail.com']
  sp.description   = %q{Tags a text with arbitrary tags
                          based on array of start/end offsets}
  sp.summary       = %q{A user who runs a search tool on a text would find 
                          multiple text fragments corresponding to the search.
                          These fragments can be found again by storing their 
                          start and end offsets. This gem places arbitrary
                          markup tags surrounding the fragments.}
  sp.homepage      = 'https://github.com/GlobalNamesArchitecture/tag_along'
  sp.license       = 'MIT'

  sp.files         = `git ls-files`.split($/)
  sp.test_files    = sp.files.grep(%r{^(spec|features)/})
  sp.require_paths = ['lib']
end
