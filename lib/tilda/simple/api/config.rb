module Tilda
  module Simple
    module Api
      class Config
        attr_accessor :api_host, :api_version, :public_key, :secret_key, :raise_api_errors

        def initialize
          @api_version = 'v1'
          @api_host = 'http://api.tildacdn.info'
          @raise_api_errors = false
        end
      end
    end
  end
end
