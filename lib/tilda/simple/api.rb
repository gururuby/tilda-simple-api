require 'httparty'
require 'tilda/simple/api/config'
require 'tilda/simple/api/errors'
require 'tilda/simple/api/request'
require 'tilda/simple/api/version'

module Tilda
  module Simple
    module Api
      class << self
        attr_writer :config

        def config
          @config ||= Config.new
        end

        def configure
          yield(config)
        end
      end
    end
  end
end