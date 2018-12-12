module StubbedRequests

  def stub_api_request(api_call, params = {})
    send api_call, params
  end

  private

  def projects_list(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getprojectslist?publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "FOUND", result: [{ id: "000000", title: "vm", descr: "" }] }.to_json
      )
    )
  end

  def projects_list_error(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getprojectslist?publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "ERROR", message: "Wrong Secret Key length", errorside: "info" }.to_json
      )
    )
  end

  def project(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getproject?projectid=#{params[:project_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "FOUND", result: { id: "000000", title: "vm", descr: "", customdomain: "" } }.to_json
      )
    )
  end

  def project_error(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getproject?projectid=#{params[:project_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "ERROR", message: "Error. Can't find project with this 'projectid' parameter", errorside: "info" }.to_json
      )
    )
  end

  def project_export(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getprojectexport?projectid=#{params[:project_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "FOUND",
                result:
                        { id:             "000000",
                          title:          "vm",
                          descr:          "",
                          customdomain:   "",
                          export_csspath: "",
                          export_jspath:  "",
                          export_imgpath: "",
                          indexpageid:    "000000",
                          page404id:      "0",
                          images:         [{ from: "https://static.tildacdn.com/img/tildafavicon.ico", to: "tildafavicon.ico" }],
                          htaccess:       "DirectoryIndex page4310238.html\n\nRewriteEngine On\n\n" } }.to_json
      )
    )
  end

  def project_export_error(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getprojectexport?projectid=#{params[:project_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "ERROR", message: "Error. Can't find project with this 'projectid' parameter", errorside: "info" }.to_json
      )
    )
  end

  def pages_list(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpageslist?projectid=#{params[:project_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "FOUND", result: [
          {
            id:         "000000",
            projectid:  "000000",
            title:      "Динозавры, насекомые и хиппи",
            descr:      "This longread contains videos, photographs and short texts.  ",
            img:        "",
            featureimg: "",
            alias:      "",
            date:       "2018-12-12 10:53:59",
            sort:       "10",
            published:  "",
            filename:   "page4310238.html" },
          {
            id:         "000001",
            projectid:  "000000",
            title:      "Дайте выспаться",
            descr:      "Пример лендинга для бара или кафе",
            img:        "",
            featureimg: "",
            alias:      "",
            date:       "2018-12-12 11:16:42",
            sort:       "20",
            published:  "",
            filename:   "page4310481.html"
          }
        ] }.to_json
      )
    )
  end

  def pages_list_error(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpageslist?projectid=#{params[:project_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "ERROR", message: "Error. Can't find project with this 'projectid' parameter", errorside: "info" }.to_json
      )
    )
  end

  def page(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpage?pageid=#{params[:page_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "FOUND", result: {
          id:         "000000",
          projectid:  "000000",
          title:      "Динозавры, насекомые и хиппи",
          descr:      "This longread contains videos, photographs and short texts.  ",
          img:        "",
          featureimg: "",
          alias:      "",
          date:       "2018-12-12 10:53:59",
          sort:       "10",
          published:  "",
          filename:   "page4310238.html",
          html:       "Page not published"
        } }.to_json
      )
    )
  end

  def page_error(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpage?pageid=#{params[:page_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "ERROR", message: "Error. Can't find page with this 'pageid' parameter", errorside: "info" }.to_json,
      )
    )
  end

  def page_full(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpagefull?pageid=#{params[:page_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "FOUND", result: {
          id:         "000000",
          projectid:  "000000",
          title:      "Динозавры, насекомые и хиппи",
          descr:      "This longread contains videos, photographs and short texts.  ",
          img:        "",
          featureimg: "",
          alias:      "",
          date:       "2018-12-12 10:53:59",
          sort:       "10",
          published:  "1544623345",
          filename:   "page4310238.html",
          html:       "<!DOCTYPE html><html></html>"
        } }.to_json
      )
    )
  end

  def page_full_error(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpagefull?pageid=#{params[:page_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "ERROR", message: "Error. Can't find page with this 'pageid' parameter", errorside: "info" }.to_json,
      )
    )
  end

  def page_export(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpageexport?pageid=#{params[:page_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "FOUND", result: {
          id:         "000000",
          projectid:  "000000",
          title:      "Динозавры, насекомые и хиппи",
          descr:      "This longread contains videos, photographs and short texts.  ",
          img:        "",
          featureimg: "",
          alias:      "",
          date:       "2018-12-12 10:53:59",
          sort:       "10",
          published:  "1544623345",
          filename:   "page4310238.html",
          images:     [
                        {
                          from: "https://static.tildacdn.com/37ed5fef-6138-40c1-a1d9-838f3c870c04/Untitled1.jpg",
                          to:   "37ed5fef-6138-40c1-a1d9-838f3c870c04__untitled1.jpg"
                        }
                      ],
          css:        [
                        {
                          from: "https://static.tildacdn.com/css/tilda-grid-3.0.min.css",
                          to:   "tilda-grid-3.0.min.css"
                        }
                      ],
          js:         [
                        {
                          from: "https://static.tildacdn.com/js/jquery-1.10.2.min.js",
                          to:   "jquery-1.10.2.min.js"
                        },
                      ],
          html:       "<!--allrecords-->"
        } }.to_json
      )
    )
  end

  def page_export_error(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpageexport?pageid=#{params[:page_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "ERROR", message: "Error. Can't find page with this 'pageid' parameter", errorside: "info" }.to_json
      )
    )
  end

  def page_full_export(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpagefullexport?pageid=#{params[:page_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "FOUND", result: {
          id:         "000000",
          projectid:  "000000",
          title:      "Динозавры, насекомые и хиппи",
          descr:      "This longread contains videos, photographs and short texts.  ",
          img:        "",
          featureimg: "",
          alias:      "",
          date:       "2018-12-12 10:53:59",
          sort:       "10",
          published:  "1544623345",
          filename:   "page4310238.html",
          images:     [
                        {
                          from: "https://static.tildacdn.com/37ed5fef-6138-40c1-a1d9-838f3c870c04/Untitled1.jpg",
                          to:   "37ed5fef-6138-40c1-a1d9-838f3c870c04__untitled1.jpg"
                        }
                      ],
          css:        [
                        {
                          from: "https://static.tildacdn.com/css/tilda-grid-3.0.min.css",
                          to:   "tilda-grid-3.0.min.css"
                        }
                      ],
          js:         [
                        {
                          from: "https://static.tildacdn.com/js/jquery-1.10.2.min.js",
                          to:   "jquery-1.10.2.min.js"
                        },
                      ],
          html:       "<!DOCTYPE html><html></html>"
        } }.to_json
      )
    )
  end

  def page_full_export_error(params = {})
    stub_request(:get,
                 "#{params[:config].api_host}/v1/getpagefullexport?pageid=#{params[:page_id]}&publickey=#{params[:config].public_key}&secretkey=#{params[:config].secret_key}"
    ).with(default_request_headers).to_return(
      default_response.merge(
        body: { status: "ERROR", message: "Error. Can't find page with this 'pageid' parameter", errorside: "info" }.to_json
      )
    )
  end

  def default_request_headers
    {
      headers: {
        'Accept'          => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'      => 'Ruby'
      }
    }
  end

  def default_response
    { status: 200, headers: { 'Content-Type' => 'application/json' } }
  end
end