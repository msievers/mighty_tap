# mighty_tap
[![Build Status](https://travis-ci.org/msievers/mighty_tap.svg)](https://travis-ci.org/msievers/mighty_tap)
[![Test Coverage](https://codeclimate.com/github/msievers/mighty_tap/badges/coverage.svg)](https://codeclimate.com/github/msievers/mighty_tap)
[![Code Climate](https://codeclimate.com/github/msievers/mighty_tap/badges/gpa.svg)](https://codeclimate.com/github/msievers/mighty_tap)

Rubys `Object#tap` is a awesome. mighty_tap tries to make it even more awesome by adding some missing features, while maintining full compatibility to the orginal `tap`. In order to make its usage more pleasant, `mighty_tap` is defined as in instance method on `Object` and aliased to `mtap`.

## Why is it even more awesome than `tap` ?
* you can give it a method name
* you can give it arguments and blocks for methods to call
* dispite calling methods on the object itself, you can provide a callable
  * in fact you can provide anything that responds to :call
* dispite the added features, it acts like the original `tap` (can act as a drop-in replacement)

## Usage

```ruby
require "mighty_tap"

#
# it can be used just like tap
#
[[[1,2,3]]].mtap(&:flatten!) # => [1,2,3]

#
# dispite the implicite &: block syntax, it can take a method name
#
[[[1,2,3]]].mtap(:flatten!) # => [1,2,3]

#
# it also takes method arguments
#
[[[1,2,3]]].mtap(:flatten!, 1) # => [[1,2,3]]

#
# if the last argument is a proc, the method is called with the procs block variant
#
[1,2,3].mtap(:map!, -> (number) { number * 2 }) # => [2,4,6]

#
# you can also give it a callable (something that responds to #call)
#
class ArrayDoubler
  def call(array)
    array.map! { |element| element * 2 }
  end
end

[1,2,3].mtap(ArrayDoubler.new) # => [2,4,6]

#
# callables can have arguments and blocks, too
#
class ArrayMultiplier
  def call(array, factor, &reducer)
    multiplied_array = array.map! { |element| element * factor }
    
    if block_given?
      yield multiplied_array
    end
  end
end

[1,2,3].mtap(ArrayMultiplier.new, 3) # => [3,6,9]
[1,2,3].mtap(ArrayMultiplier.new, 3, -> (array) { array.delete_if { |int| int < 9 } }) # => [9]

#
# this can all be combinded with taps original block syntax
#
[1,2,3].mtap(ArrayDoubler.new) do |doubled_array|
  doubled_array.map! { |element| element * element }
end # => [4, 16, 36]
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mighty_tap'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mighty_tap

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/msievers/mighty_tap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
