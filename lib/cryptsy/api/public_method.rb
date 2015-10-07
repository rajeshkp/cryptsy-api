require "httparty"

module Cryptsy
  module API
    class PublicMethod
      include HTTParty
      base_uri "http://pubapi2.cryptsy.com"

      def execute_method(all_markets, single_market, marketid)
        api_method = marketid.nil? ? all_markets : single_market
        query = { method: api_method }
        query["marketid"] = marketid if marketid

        response = self.class.get("/api.php", query: query)
        begin
          response_body = JSON.parse(response.body)
          response = [true, response_body]
        rescue => e
          response = [false, e]
        end

        response
      end
    end
  end
end