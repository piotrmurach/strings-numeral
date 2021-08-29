<div align="center">
  <img width="225" src="https://github.com/piotrmurach/strings/blob/master/assets/strings_logo.png" alt="strings logo" />
</div>

# Strings::Numeral

[![Gem Version](https://badge.fury.io/rb/strings-numeral.svg)][gem]
[![Actions CI](https://github.com/piotrmurach/strings-numeral/workflows/CI/badge.svg?branch=master)][gh_actions_ci]
[![Build status](https://ci.appveyor.com/api/projects/status/494htkcankqegwtg?svg=true)][appveyor]
[![Maintainability](https://api.codeclimate.com/v1/badges/de0c5ad1cba6715b7135/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/strings-numeral/badge.svg?branch=master)][coverage]
[![Inline docs](https://inch-ci.org/github/piotrmurach/strings-numeral.svg?branch=master)][inchpages]

[gem]: https://badge.fury.io/rb/strings-numeral
[gh_actions_ci]: https://github.com/piotrmurach/strings-numeral/actions?query=workflow%3ACI
[appveyor]: https://ci.appveyor.com/project/piotrmurach/strings-numeral
[codeclimate]: https://codeclimate.com/github/piotrmurach/strings-numeral/maintainability
[coverage]: https://coveralls.io/github/piotrmurach/strings-numeral?branch=master
[inchpages]: https://inch-ci.org/github/piotrmurach/strings-numeral

> Express numbers as string numerals.

**Strings::Numeral** provides conversions of numbers to numerals component for [Strings](https://github.com/piotrmurach/strings).

## Features

* No monkey-patching String class
* Functional API that can be easily wrapped by other objects
* Instance based configuration
* Highly performant

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
  * [2.4 monetize](#24-monetize)
  * [2.5 romanize](#25-romanize)
  * [2.6 configuration](#26-configuration)
* [3. Extending core classes](#3-extending-core-classes)

## 1. Usage

**Strings::Numeral** helps to express any number as a numeral in words. It exposes few methods to achieve this. For example, you can express a number as a cardinal numeral using `cardinalize`:

```ruby
Strings::Numeral.cardinalize(1234)
# => "one thousand, two hundred thirty four"
```

But you're not limited to converting integers only. It can handle decimals as well:

```ruby
Strings::Numeral.cardinalize(1234.567)
# => "one thousand, two hundred thirty four and five hundred sixty seven thousandths"
```

For more options on how to customize formatting see [configuration](#25-configuration) section.

Similarly, you can convert a number to a ordinal numeral with `ordinalize`:

```ruby
Strings::Numeral.ordinalize(1234)
# => "one thousand, two hundred thirty fourth"
```

You can also convert a number to a short ordinal:

```ruby
Strings::Numeral.ordinalize(1234, short: true)
# => "1234th"
```

Using `monetize` you can convert any number into a monetary numeral:

```ruby
Strings::Numeral.monetize(1234.567)
# => "one thousand, two hundred thirty four dollars and fifty seven cents",
```

To turn a number into a roman numeral use `romanize`:

```ruby
Strings::Numeral.romanize(2020)
# => "MMXX"
```

## 2. API

### 2.1 numeralize

The `normalize` is a wrapping method for the [cardinalize](#22-cardinalize) and [ordinalize](#23-ordinalize) methods. By default it converts a number to cardinal numeral:

```ruby
Strings::Numeral.numeralize(1234.567)
# => "one thousand, two hundred thirty four and five hundred sixty seven thousandths"
```

You can also make it convert to ordinal numerals using `:term` option:

```ruby
Strings::Numeral.numeralize(1234.567, term: :ord)
# => "one thousand, two hundred thirty fourth and five hundred sixty seven thousandths"
```

### 2.2 cardinalize

To express a number as a cardinal numeral use `cardinalize` or `cardinalise`.

```ruby
Strings::Numeral.cardinalize(1234)
# => "one thousand, two hundred thirty four"
```

You're not limited to integers only. You can also express decimal numbers as well:

```ruby
Strings::Numeral.cardinalize(123.456)
# => "one hundred twenty three and four hundred fifty six thousandths"
```

By default the fractional part of a decimal number is expressed as a fraction. If you wish to spell out fractional part digit by digit use `:decimal` option with `:digit` value:

```ruby
Strings::Numeral.cardinalize(123.456, decimal: :digit)
# => "one hundred twenty three point four five six"
```

You may prefer to use a different delimiter for thousand's. You can do use by passing the `:delimiter` option:

```ruby
Strings::Numeral.cardinalize(1_234_567, delimiter: " and ")
# => "one million and two hundred thirty four thousand and five hundred sixty seven"
```

To change word that splits integer from factional part use `:separator` option:

```ruby
Strings::Numeral.cardinalize(1_234.567, separator: "dot")
# => "one thousand, two hundred thirty four dot five hundred sixty seven thousandths"
```

### 2.3 ordinalize

To express a number as a cardinal numeral use `ordinalize` or `ordinalise`.

```ruby
Strings::Numeral.ordinalize(1234)
# => "one thousand, two hundred thirty fourth"
```

You're not limited to integers only. You can also express decimal numbers as well:

```ruby
Strings::Numeral.ordinalize(123.456)
# => "one hundred twenty third and four hundred fifty six thousandths"
```

By default the fractional part of a decimal number is expressed as a fraction. If you wish to spell out fractional part digit by digit use `:decimal` option with `:digit` value:

```ruby
Strings::Numeral.ordinalize(123.456, decimal: :digit)
# => "one hundred twenty third point four five six"
```

You may prefer to use a different delimiter for thousand's. You can do use by passing the `:delimiter` option:

```ruby
Strings::Numeral.ordinalize(1_234_567, delimiter: " and ")
# => "one million and two hundred thirty four thousand and five hundred sixty seventh"
```

To change word that splits integer from factional part use `:separator` option:

```ruby
Strings::Numeral.ordinalize(1_234.567, separator: "dot")
# => "one thousand, two hundred thirty fourth dot five hundred sixty seven thousandths"
```

### 2.4 monetize

To express a number as a monetary numeral use `monetize` or `monetise`.

```ruby
Strings::Numeral.monetize(123.456)
# => "one hundred twenty three dollars and forty six cents",
```

By default `monetize` displays money using `USD` currency. You can change this with the `:currency` option that as value accepts internationally recognised symbols. Currently support currencies are: `EUR`, `GBP`, `JPY`, `PLN` and `USD`.

```ruby
Strings::Numeral.monetize(123.456, currency: :jpy)
# => "one hundred twenty three yen and forty six sen"
```

### 2.5 romanize

To convert a number into a Roman numeral use `romanize`:

```ruby
Strings::Numeral.romanize(2020)
# => "MMXX"
```

### 2.6 configuration

All available configuration settings are:

* `currency` - Adds currency words for integer and fractional parts. Supports `EUR`, `GBP`, `JPY`, `PLN` and `USD`. Defaults to `USD`.
* `decimal` - Formats fractional part of a number. The `:digit` value spells out every digit and the `:fraction` appends divider word. Defaults to `:fraction`.
* `delimiter` - Sets the thousands delimiter. Defaults to `", "`.
* `separator` - Sets the separator between the fractional and integer parts. Defaults to `"and"` for `:fraction` and `"point"` for `:digit` option.
* `strict` - Enables number validation for the input parameter. Defaults to `false`.
* `trailing_zeros` - If `true` keeps trailing zeros at the end of the fractional part. Defaults to `false`.

The above settings can be passed as keyword arguments:

```ruby
Strings::Numeral.cardinalize("12.100", trailing_zeros: true, decimal: :digit)
# => "twelve point one zero zero"
```

Or you can configure the settings for an instance during initialisation:

```ruby
numeral = Strings::Numeral.new(delimiter: "; ", separator: "dot")
```

After initialisation, you can use `configure` to change settings inside a block:

```ruby
numeral.configure do |config|
  config.delimiter "; "
  config.separator "dot"
  config.decimal :digit
  config.trailing_zeros true
end
```

Once configured, you can use the instance like so:

```ruby
numeral.cardinalize("1234.56700")
# => "one thousand; two hundred thirty four dot five six seven zero zero"
```

## 3. Extending Core Classes

Though it is highly discouraged to pollute core Ruby classes, you can add the required methods to `String`, `Float` and `Integer` classes using refinements.

For example, if you wish to only extend `Float` class with `cardinalize` method do:

```ruby
module MyFloatExt
  refine Float do
    def cardinalize(**options)
      Strings::Numeral.cardinalize(self, **options)
    end
  end
end
```

Then `cardinalize` method will be available for any float number where refinement is applied:

```ruby
using MyFloatExt

12.34.cardinalize
# => "twelve and thirty four"
```

However, if you want to include all the **Strings::Numeral** methods in `Float`, `Integer` and `String` classes, you can use provided extensions file:


```ruby
require "strings/numeral/extensions"

using Strings::Numeral::Extensions
```

Alternatively, you can choose what class you wish to refine with all the methods:

```ruby
require "bigdecimal"
require "strings/numeral/extensions"

module MyBigDecimalExt
  refine BigDecimal do
    include Strings::Numeral::Extensions::Methods
  end
end

using MyBigDecimalExt
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/strings-numeral. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/piotrmurach/strings-numeral/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Strings::Numeral project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/strings-numeral/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2019 Piotr Murach. See LICENSE for further details.
