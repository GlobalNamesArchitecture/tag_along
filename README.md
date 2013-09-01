TagAlong
========

[![Gem Version][1]][2]
[![Continuous Integration Status][3]][4]
[![Coverage Status][5]][6]
[![CodePolice][7]][8]
[![Dependency Status][9]][10]

A user who runs a search tool against a text would find 
multiple text fragments corresponding to the search.
These fragments can be found again by storing their 
start and end offsets. This gem places arbitrary
markup tags surrounding the fragments.

Installation
------------

Add this line to your application's Gemfile:

    gem 'tag_along'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tag_along

Usage
-----

To add tags to a text:

    tg = TagAlong.new(some_text)
    offsets = [[2, 5], [9, 22], [33, 35]]
    tg.tag('<my_tag>', '</my_tag>', offsets)


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Copyright
---------

Authors: [Dmitry Mozzherin][11] 

Copyright (c) 2013 Marine Biological Laboratory. See LICENSE for
further details.

[1]: https://badge.fury.io/rb/tag_along.png
[2]: http://badge.fury.io/rb/tag_along
[3]: https://secure.travis-ci.org/GlobalNamesArchitecture/tag_along.png
[4]: http://travis-ci.org/GlobalNamesArchitecture/tag_along
[5]: https://coveralls.io/repos/GlobalNamesArchitecture/tag_along/badge.png?branch=master
[6]: https://coveralls.io/r/GlobalNamesArchitecture/tag_along?branch=master
[7]: https://codeclimate.com/github/GlobalNamesArchitecture/tag_along.png
[8]: https://codeclimate.com/github/GlobalNamesArchitecture/tag_along
[9]: https://gemnasium.com/GlobalNamesArchitecture/tag_along.png
[10]: https://gemnasium.com/GlobalNamesArchitecture/tag_along
[11]: https://github.com/dimus
