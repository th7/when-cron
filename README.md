# When-Cron

A basic cron implementation in Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'when-cron'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install when-cron

## Usage

Compare to anything that has an interface like Ruby's Time class with ==.

```When::Cron.new('* * * * *') == Time.now # => true```

Numbers, *, and abbreviations (SUN, JAN, etc) are supported for values.

, - and / are supported as operators.

```When::Cron.valid?('a b c d e') # => false```
```When::Cron.valid('a b c d e') # => nil```

When::Cron will only validate your string when specifically asked. This allows faster analysis of previously validated strings, but might lead to silent failures for invalid strings.

```When::Cron.new('100 * * * *') == Time.now # => false```

When::Cron will raise an error for extremely nonsensical cron strings.

```When::Cron.new('this is getting ridiculous') # => raises When::Cron::InvalidString```

When::Cron follows this rule (man 5 crontab)

> Note: The day of a command's execution can be specified by two fields -- day of month, and day of week.  If both fields are restricted (ie, are not *), the command will be run
     when either field matches the current time.  For example, ``30 4 1,15 * 5'' would cause a command to be run at 4:30 am on the 1st and 15th of each month, plus every Friday.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
