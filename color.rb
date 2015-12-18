require "json"
require "openssl"
require "net/http"
require "base64"

module Color
    class SDK
        def initialize ( apikey, apisecret )

            accounts = apikey.split( "/" );
            account = accounts.at( 0 );
            decoded = Base64.decode64( apisecret ).split( "/" );
            rand = decoded.at( 0 );
            awsaccount = decoded.at( 2 );
            region = decoded.at( 3 );


            @queue = [ "https://sqs." + region + ".amazonaws.com",
                awsaccount,
                "sdk-" + account + "-" + rand
            ].join( "/" )

            @apikey = apikey
            @apisecret = apisecret
            @buffer = "";
        end

        def write ( table, entry )
            entry[:__table] = table;
            @buffer += entry.to_json + "\n"
            if @buffer.size >= 60000
                flush() # auto-flush
            end

            return self
        end

        def flush
            buffer = @buffer
            @buffer = ""

            uri = URI.parse( @queue )
            http = Net::HTTP.new( uri.host, uri.port )
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            req = Net::HTTP::Post.new( uri.path )
            req.body = "Action=SendMessage" +
                "&MessageAttribute.1.Name=key" +
                "&MessageAttribute.1.Value.DataType=String" + 
                "&MessageAttribute.1.Value.StringValue=" + @apikey + 
                "&MessageAttribute.2.Name=secret" +
                "&MessageAttribute.2.Value.DataType=String" +
                "&MessageAttribute.2.Value.StringValue=" + @apisecret +
                "&MessageBody=" + buffer.encode( "utf-8" )
            
            Thread.new do 
                res = http.request( req )
            end

            return self
        end
    end
end