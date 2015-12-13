# color-sdk-ruby

#### Usage

```ruby
require "color"

# init with the SQS endpoint
sdk = Color::SDK.new( "API-KEY", "API-SECRET" )

# add arbitrary objects to the internal buffer
sdk.write("reports", { id: "15", event: "install", user: 15, device: "iPhone" }) 
sdk.write("reports", { event: "click", user: 12, device: "iPad" })
sdk.flush() # send the internal buffer to the queue
```