# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tag_along/version'

Gem::Specification.new do |spec|
  spec.name          = "tag_along"
  spec.version       = TagAlong::VERSION
  spec.authors       = ["Dmitry Mozzherin"]
  spec.email         = ["dmozzherin@gmail.com"]
  spec.description   = %q{Tags a text with arbitrary tags
                          based on array of start/end offsets}
  spec.summary       = %q{A user who runs a search tool on a text would find 
                          multiple text fragments corresponding to the search.
                          These fragments can be found again by storing their 
                          start and end offsets. This gem places arbitrary
                          markup tags surrounding the fragments.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rr"
end
