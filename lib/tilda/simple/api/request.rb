module Tilda
  module Simple
    module Api
      class Request
        include HTTParty
        extend ErrorsHandler

        def initialize(public_key: nil, secret_key: nil)
          config = Api.config

          public_key ||= config.public_key
          secret_key ||= config.secret_key

          self.class.base_uri "#{config.api_host}/#{config.api_version}"
          self.class.default_params publickey: public_key, secretkey: secret_key
        end

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
