module Tilda
  module Simple
    module Api
      module ErrorsHandler
        def get(path, params = {})
          handle_errors { super(path, params) }
        end

        private

        def handle_errors(&block)
          response = block.call
          check_response(response) if Api.config.raise_api_errors
          response
        end

        def check_response(response)
          raise api_error_class(response), response['message'] if response['status'] == 'ERROR'
        end

        def api_error_class(response)
          case response['message']
          when /Wrong Secret Key length|Wrong Public Key length/
            Errors::InvalidCredentials
          when /Can't find project with this 'projectid' parameter/
            Errors::ProjectNotFound
          when /Can't find page with this 'pageid' parameter/
            Errors::PageNotFound
          else
            Errors::Error
          end
        end
      end
    end
  end
end
