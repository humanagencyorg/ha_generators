# HaGenerators

This gem adds generators for services, workers, and serializers.
Sometimes we feel that we need to move some logic to a service file.
This PR helps to make this process easier.
Just run `rails g ha_generators:service foo::bar` and you'll have:
```
create app/services/foo/bar.rb
create spec/services/foo/bar_spec.rb
```
## Installation

Add this line to your application's Gemfile:

```ruby
gem "ha_generators", github: "humanagencyorg/ha_generators"
```

And then execute:

    $ bundle install

## Usage

```
# create service Foo::BarService
rails g ha_generators:service foo::bar 

# create worker Foo::BarWorker
rails g ha_generators:worker foo::bar

# create serializer Foo::BarSerializer
rails g ha_generators:service foo::bar
```
### Generated service example
`rails g ha_generators:service foo::bar` generates:

```ruby
# app/services/foo/bar.rb
# frozen_string_literal: true

class Foo::Bar < ApplicationService
  def initialize
  end

  def call
    true
  end
end

```
```ruby
# spec/services/foo/bar_spec.rb
# frozen_string_literal: true

require "rails_helper"

RSpec.describe Foo::Bar, type: :service do
  describe ".call" do
    it "returns true" do
      result = described_class.call

      expect(result).to eq true
    end
  end
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/humanagencyorg/ha_generators.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
