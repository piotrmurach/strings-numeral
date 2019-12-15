<div align="center">
  <img width="225" src="https://github.com/piotrmurach/strings/blob/master/assets/strings_logo.png" alt="strings logo" />
</div>

# Strings::Numeral

[![Gem Version](https://badge.fury.io/rb/strings-numeral.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/strings-numeral.svg?branch=master)][travis]
[![Build status](https://ci.appveyor.com/api/projects/status/494htkcankqegwtg?svg=true)][appveyor]
[![Maintainability](https://api.codeclimate.com/v1/badges/de0c5ad1cba6715b7135/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/strings-numeral/badge.svg?branch=master)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/strings-numeral.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/strings-numeral
[travis]: http://travis-ci.org/piotrmurach/strings-numeral
[appveyor]: https://ci.appveyor.com/project/piotrmurach/strings-numeral
[codeclimate]: https://codeclimate.com/github/piotrmurach/strings-numeral/maintainability
[coverage]: https://coveralls.io/github/piotrmurach/strings-numeral?branch=master
[inchpages]: http://inch-ci.org/github/piotrmurach/strings-numeral

> Express numbers as string numerals.

**Strings::Numeral** provides conversions of numbers to numerals component for [Strings](https://github.com/piotrmurach/strings).

## Features

* No monkey-patching String class
* Functional API that can be easily wrapped by other objects

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'strings-numeral'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strings-numeral

## Contents

* [1. Usage](#1-usage)
* [2. API](#2-api)
  * [2.1 numeralize](#21-numeralize)
  * [2.2 cardinalize](#22-cardinalize)
  * [2.3 ordinalize](#23-ordinalize)
* [3. Extending String class](#3-extending-string-class)

## 1. Usage

**Strings::Numeral** aims to express any number as a numeral in words. To do this it provides few methods. For example, to express a number as a cardinal numeral use `cardinalize`:

```ruby
Strings::Numeral.cardinalize(1234)
# => one thousand, two hundred thirty four
```

But you're not limited to converting integers only. It can handle decimals as well:

```ruby
Strings::Numeral.cardinalize(1234.567)
# => "one thousand, two hundred thirty four and five hundred sixty seven thousandths"
```

For more options on how to customize see [configuration](#24-configuration)

To convert a number to to a ordinal numeral:

```ruby
Strings::Numeral.ordinalize(1234)
# => one thousand, two hundred thirty fourth
```

You can convert a number to a short ordinal:

```ruby
Strings::Numeral.ordinalize(1234, short: true)
# => 1234th
```

## 2. API

### 2.1 numeralize

### 2.2 cardinalize

To express a number as a cardinal numeral use `cardinalize` or `cardinalise`.

```ruby
Strings::Numeral.cardinalize(1234)
# => "one thousand, two hundred thirty four"
```

You're not limited to integers only. You can also express decimal numbers:

```ruby
Strings::Numeral.cardinalize(123.456)
# => "one hundred twenty three and four hundred fifty six thousandths"
```

By default the fractional part of a decimal number is expressed as a fraction If you wish to spell out it digit by digit use `:decimal` option with `:digit` value:

```ruby
Strings::Numeral.cardinalize(123.456, decimal: :digit)
# => "one hundred twenty three point four five six"
```

### 2.3 ordinalize

## 3. Extending String class

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/strings-numeral. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Strings::Numeral project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/strings-numeral/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2019 Piotr Murach. See LICENSE for further details.
