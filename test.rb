require "./color"

# test queue need to be generated
sdk = Color::SDK.new( "testkey", "testsecrete" )
sdk.write("reports", { hello: "world" } )
sdk.flush()

sleep( 5 )