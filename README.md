TagAlong
========

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

Authors: [Dmitry Mozzherin][1], 

Copyright (c) 2013 Marine Biological Laboratory. See LICENSE for
further details.

[1]: https://github.com/dimus
