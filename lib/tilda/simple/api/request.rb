module Tilda
  module Simple
    module Api
      class Request
        class << self
          def new(public_key:nil, secret_key:nil)
            Class.new(AbstractRequest){|klass|
              config = Api.config
              public_key ||= config.public_key
              secret_key ||= config.secret_key
              klass.base_uri "#{config.api_host}/#{config.api_version}"
              klass.default_params publickey: public_key, secretkey: secret_key
            }.new
          end
        end

        class AbstractRequest
          include HTTParty

          def projects_list
            self.class.get('/getprojectslist')
          end

          def project(project_id)
            self.class.get('/getproject', query: { projectid: project_id })
          end

          def project_export(project_id)
            self.class.get('/getprojectexport', query: { projectid: project_id })
          end

          def pages_list(project_id)
            self.class.get('/getpageslist', query: { projectid: project_id })
          end

          def page(page_id)
            self.class.get('/getpage', query: { pageid: page_id })
          end

          def page_full(page_id)
            self.class.get('/getpagefull', query: { pageid: page_id })
          end

          def page_export(page_id)
            self.class.get('/getpageexport', query: { pageid: page_id })
          end

          def page_full_export(page_id)
            self.class.get('/getpagefullexport', query: { pageid: page_id })
          end
        end
      end
    end
  end
end
