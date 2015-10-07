require "cryptsy/api/version"
require "httparty"
require "uri"
require "openssl"
require "json"

module Cryptsy
  module API
    autoload :Client,                'cryptsy/api/client'
    autoload :PrivateMethod,         'cryptsy/api/private_method'
    autoload :PublicMethod,          'cryptsy/api/public_method'
  end
end