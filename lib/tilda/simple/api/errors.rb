module Tilda
  module Simple
    module Api
      module Errors
        class Error < StandardError; end

        class ResponseError < Error
          attr_reader :status_code

          def initialize(response)
            @message = response.message
            @status_code = response.code
          end
        end
      end
    end
  end
end
