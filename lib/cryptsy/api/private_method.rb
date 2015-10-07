module Cryptsy
  module API
    class PrivateMethod
      include HTTParty
      base_uri "https://api.cryptsy.com"

      def initialize(key=nil, secret=nil)
        @key = key
        @secret = secret
      end

      def execute_method(method_name, params)
        post_data = {method: method_name, nonce: nonce}.merge(params)
        post_body = URI.encode_www_form(post_data)

        response = self.class.post("/api",
                           headers: { "User-Agent" => "Mozilla/4.0 (compatible; Cryptsy API ruby client)",
                                    "Sign" => signed_message(post_body),
                                    "Key" => @key,
                           },
                           body: post_data)
        begin
          response_body = JSON.parse(response.body)
          response = [true, response_body]
        rescue => e
          response = [false, e]
        end

        response
      end

      def auth_changed?(key, secret)
        return @key == key && @secret == secret
      end

     private

       def nonce
         Time.now.to_i
       end

       def signed_message(msg)
         OpenSSL::HMAC.hexdigest('sha512', @secret, msg)
       end

    end

  end
end
