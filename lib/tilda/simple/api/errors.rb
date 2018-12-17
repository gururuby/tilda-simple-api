module Tilda
  module Simple
    module Api
      module Errors
        class Error < StandardError; end
        class InvalidCredentials < Error; end
        class ProjectNotFound < Error; end
        class PageNotFound < Error; end
      end
    end
  end
end
