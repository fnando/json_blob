# JSONBlob

[![Travis-CI](https://travis-ci.org/fnando/json_blob.svg)](https://travis-ci.org/fnando/json_blob)
[![Code Climate](https://codeclimate.com/github/fnando/json_blob/badges/gpa.svg)](https://codeclimate.com/github/fnando/json_blob)
[![Test Coverage](https://codeclimate.com/github/fnando/json_blob/badges/coverage.svg)](https://codeclimate.com/github/fnando/json_blob/coverage)
[![Gem](https://img.shields.io/gem/v/json_blob.svg)](https://rubygems.org/gems/json_blob)
[![Gem](https://img.shields.io/gem/dt/json_blob.svg)](https://rubygems.org/gems/json_blob)

Create `<script type="application/json;base64">` tags to safely send data to the UI. You can then use <https://github.com/fnando/json_blob-js> to load this data on the client-side.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "json_blob"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_blob

## Usage

To output data, use the `json_blob` method like the following:

```erb
<%= json_blob :user, @user %>
```

This will output something like:

```html
<script data-name="user" type="application/json;base64">eyJuYW1lIjoiSm9obiBEb2UifQ==</script>
```

On the client-side you can load the data with something like the following. You're better off using <https://github.com/fnando/json_blob-js> to avoid copying 'n' pasting code between projects.

```js
function loadJSONBlob(name, defaults = null) {
  const element = document.querySelector(`script[type="application/json;base64"][data-name="${name}"]`);

  if (!element) {
    return defaults;
  }

  return JSON.parse(atob(element.innerHTML));
}

const user = loadJSONBlob("user");
```

### Ruby

You can use the methods to encode/decode payloads directly.

```ruby
encoded = JSONBlob.dump(a: 1)
decoded = JSONBlob.parse(encoded)
```

You can also set your favorite JSON engine. The requirement is that it must implement the `dump(data)` and `parse(data)` methods.

```ruby
module CustomJSONEngine
  def self.dump(data)
    JSON.dump(data.merge(dump: true))
  end

  def self.parse(data)
    JSON.parse(data).merge(parse: true)
  end
end

JSONBlob.json_engine = CustomJSONEngine

encoded = JSONBlob.dump(a: 1)
decoded = JSONBlob.parse(encoded)
#=> {"a" => 1, "dump": true, "parse": true}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fnando/json_blob. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JSONBlob project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fnando/json_blob/blob/master/CODE_OF_CONDUCT.md).
