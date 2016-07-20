# Panoply SDK for Ruby

This SDK allows users to send data objects to the Panoply platform.

Before using the SDK, you need to retrieve your API Key and API Secret from the Panoply platform.

- Log into the platform and navigate to the [Sources page](https://beta.panoply.io/#/sources).
- Click "Add Data Source" and select "Panoply SDK" from the list.
- Take note of your API Key and API Secret

### Install

Add a reference to your Gemfile

    gem "panoply-sdk-ruby": "git://github.com/panoplyio/panoplt-sdk-ruby.git"

### Usage

```ruby
require "panoply-sdk-ruby"

# init with the SQS endpoint
sdk = Color::SDK.new( "<API-KEY>", "<API-SECRET>" )

# add arbitrary objects to the internal buffer
sdk.write("reports", { id: "15", event: "install", user: 15, device: "iPhone" })
sdk.write("reports", { event: "click", user: 12, device: "Web" })
sdk.flush() # force a flush of the internal buffer to the queue
```

See included `example.rb` for a usable example

### Note about asynchronous requests

The SDK sends HTTP POST requests in an asynchronous manner. Because of this it is
advised to allow a sufficient amount of time for all the requests to be sent before
allowing the code using the SDK to exit.
