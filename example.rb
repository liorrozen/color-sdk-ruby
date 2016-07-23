require "./lib/panoply-sdk-ruby.rb"
require "base64"

# Extract these values from the platform when you
# selet Panoply SDK as a data source
apikey = 'panoply/tp894taxq146lxr'
apisecret = 'a2dvcGZ0b3JmZnRybzFvci9hMDk4NmExMi00NTVhLTRiODgtYTAxNC0zZTZkZDJhOThiOGEvMDM3MzM1OTk5NTYyL3VzLWVhc3QtMQ=='

sdk = Color::SDK.new( apikey, apisecret)

events = [ :install, :click, :purchase, :win, :init, :foo, :bar, :enuf ]

# Add arbitrary objects to the internal buffer
5.times do
  id = Random.rand().to_s
  event = events.sample
  user = Random.rand( 1000 )
  sdk.write("reports", {
    id: id,
    event: event,
    user: user,
    obj: {
      name: 'flat',
      flat: 'name'
    },
    simple_arr: [ '4', '8', '15', '16' ],
    obj_arr: [
      { pos: '1st', evt: event, user: user },
      { pos: '2nd', evt: event, user: user }
    ],
    one_nested_obj_arr: [
      { pos: '1st', evt: { user: user, type: event } },
      { pos: '2nd', evt: { user: user, type: event } },
    ]
  })
end

sdk.flush() # send the internal buffer to the queue

# Wait for the sdk to finish making HTTP requests
wait = 5
wait.times do |i|
  print "Giving the sdk enough time to send remaining data ( #{wait-i} seconds )\r"
  sleep(1)
end
puts
