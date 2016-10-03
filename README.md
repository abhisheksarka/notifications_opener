[![Gem Version](https://badge.fury.io/rb/notifications_opener.svg)](http://badge.fury.io/rb/notifications_opener)

# Notifications Opener

Blocks SMSs from being delivered in development. Instead opens a preview in the browser by intercepting the request to the configured SMS API.

<img src="https://s13.postimg.org/r6yadbbg7/Screen_Shot_2016_10_03_at_5_35_05_PM.png" width="350"/>
<img src="https://s13.postimg.org/5w0q91tbr/Screen_Shot_2016_10_03_at_5_32_34_PM.png" width="350"/>

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


# For Android Notifications
NotificationsOpener.configure(:android) do | c |
  # The GCM API call to intercept
  c[:url] = /.*android.googleapis.com\/gcm.*/
  c[:location] = '/tmp'
end

```

## Development and Experimentation

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### SMS Notifications
Copy and paste the following lines of code after you run `bin/console` from the gem directory

```ruby
NotificationsOpener.configure(:sms) do | c |
  # Param name for the sender that will be passed to the SMS API
  c[:from_key_name] = "sender"

  # Param name for the receiver that will be passed to the SMS API
  c[:to_key_name] = "to"

  # Param name for the message that will be passed to the API
  c[:message_key_name] = "message"

  # Location to store the preview email files, usually tmp
  c[:location] = '/tmp'

  # The SMS API call to intercept
  c[:url] = /.*alerts.springedge.com.*/
end
Net::HTTP.get('alerts.springedge.com', '/?to=8095456768&sender=NSTWY&message=Hello')
```

### Android Notifications
Copy and paste the following lines of code after you run `bin/console` from the gem directory

```ruby
NotificationsOpener.configure(:android) do | c |
  # The GCM API call to intercept
  c[:url] = /.*android.googleapis.com\/gcm.*/
  c[:location] = '/tmp'
end

data = {
  "to" => "111111111",
  "data" => {
    "type" => "10041",
    "message" => "You are required to pay an amount of 2500.0 against Rent september. Click here to view & pay",
    "img_link" => nil,
    "title" => "Payment update",
    "time" => "1475480496",
    "deep_link_url" => nil,
    "data_json" => nil,
    "short_msg" => "You are required to pay an amount of 200.0",
    "action_button" => [
      {
        "text" => "View details",
        "screen" => "5",
        "data_json" => nil,
        "deep_link_url" => ""
      }
    ]
  }
}
params = {
  :body => data.to_json,
  :headers => {
    'Content-Type' => 'application/json',
    'Authorization' => "key=#{@api_key}"
  }
}
require 'httparty'
include HTTParty

self.class.post('http://android.googleapis.com/gcm', params)
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abhisheksarka/notifications_opener. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
