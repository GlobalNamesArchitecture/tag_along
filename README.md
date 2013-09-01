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

Gem works with UTF-8 and ASCII7 texts.

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

For example you want to tag days of week from a text:

    text = "There's Sunday and there's Monday"

To add tags to a text:

    offsets = [[8,13], [27,32]]
    tg = TagAlong.new(text, offsets)
    
    tg.tag('<my_tag>', '</my_tag>')
    puts tg.tagged_text
    # There's <my_tag>Sunday</my_tag> and there's <my_tag>Monday</my_tag>
    
    tg.tag('<em>', '</em>')
    puts tg.tagged_text
    # There's <em>Sunday</em> and there's <em>Monday</em>

Notice that you can retag the text as many times as you want.

### Offsets
  
To prepare offsets from an arbitrary object:
    
    # Array of arrays
    my_ary = [[8,13], [27,32]]
    offsets = TagAlong::Offsets.new(my_ary)

    # Array of hashes
    my_hash = [{ start: 8, end:13 }, { start:27, end:32 }]
    offsets = TagAlong::Offsets.new(my_hash,
                                    offset_start: 'start'
                                    offset_end: 'end')
    or
    offsets = TagAlong::Offsets.new(my_hash,
                                    offset_start: :start,
                                    offset_end: :end)

    # Array of objects
    require 'ostruct'
    my_obj = [OpenStruct.new(s: 8, e: 13), OpenStruct.new(s: 27, e: 32)]
    offsets = TagAlong::Offsets.new(my_obj,
                                    offset_start: :s,
                                    offset_end: :e)

In all cases you can instantiate TagAlong with resulting offsets:

    tg = TagAlong.new(text, offsets)
    tg.tag('|hi|', '|bye|')

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
