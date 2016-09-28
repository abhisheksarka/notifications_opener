[![Gem Version](https://badge.fury.io/rb/notifications_opener.svg)](http://badge.fury.io/rb/notifications_opener)

# Notifications Opener

Blocks SMSs from being delivered in development. Instead opens a preview in the browser by intercepting the request to the configured SMS API.


![alt tag](https://cloud.githubusercontent.com/assets/4833588/17463047/cabef4a2-5cdb-11e6-8117-f2a27c71c54c.png)
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notifications_opener'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notifications_opener

## Usage

Add the following configuration in your `development.rb`. The following is an example for springedge. It will probably differ based on your provider.

```ruby
# Blocks SMSs from being delivered in development
# Instead opens a preview in the browser by intercepting the request to
# the configured SMS API
NotificationsOpener.configure do | c |
  # Param name for the sender that will be passed to the SMS API
  c[:from_key_name] = "sender"

  # Param name for the receiver that will be passed to the SMS API
  c[:to_key_name] = "to"

  # Param name for the message that will be passed to the API
  c[:message_key_name] = "message"

  # Location to store the preview email files, usually tmp
  c[:location] = Rails.root.join("tmp").to_s

  # The SMS API call to intercept
  c[:url] = /.*alerts.springedge.com.*/
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abhisheksarka/notifications_opener. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
