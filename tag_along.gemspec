# coding: utf-8
require File.expand_path('../lib/tag_along/version', __FILE__)

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

  sp.add_runtime_dependency 'json', '~> 1.7'

  sp.add_development_dependency 'rake', '~> 10.1'
  sp.add_development_dependency 'bundler', '~> 1.3'
  sp.add_development_dependency 'rspec', '~> 2.14'
  sp.add_development_dependency 'rr', '~> 1.1'
  sp.add_development_dependency 'coveralls', '~> 0.7'
  sp.add_development_dependency 'debugger', '~> 1.6'
  
end
