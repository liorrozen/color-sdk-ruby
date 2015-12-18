require "./color"

sdk = Color::SDK.new( "testkey", "testsecret" )
sdk.write("reports", { hello: "world" } )
sdk.flush()

sleep( 5 )
