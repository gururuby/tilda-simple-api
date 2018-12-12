RSpec.describe Tilda::Simple::Api::Request do
  let(:project_id) { ENV.fetch('TILDA_PROJECT_ID', '000000') }
  let(:page_id) { ENV.fetch('TILDA_PAGE_ID', '000000') }
  let!(:config) { Tilda::Simple::Api.config }

  subject { described_class.new }

  before do
    Tilda::Simple::Api.configure do |config|
      config.public_key = ENV.fetch('TILDA_PUBLIC_KEY', 'public-key')
      config.secret_key = ENV.fetch('TILDA_SECRET_KEY', 'secret-key')
    end
  end

  describe '#projects_list' do
    context 'success call' do
      let(:response) { subject.projects_list }

      before do
        stub_api_request(:projects_list, config: config)
      end

      it 'return status FOUND' do
        response = subject.projects_list
        expect(response['status']).to eq 'FOUND'
      end

      it 'return projects list' do
        response = subject.projects_list
        expect(response['result']).to match_array [{ "descr" => "", "id" => project_id, "title" => "vm" }]
      end
    end

    context 'error call' do
      let(:response) { subject.projects_list }

      before do
        allow(config).to receive(:secret_key).and_return('broken key')
        stub_api_request(:projects_list_error, config: config)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Wrong Secret Key length"
      end
    end
  end

  describe '#project' do
    context 'success call' do
      let(:response) { subject.project(project_id) }

      before do
        stub_api_request(:project, config: config, project_id: project_id)
      end

      it 'return status FOUND' do
        expect(response['status']).to eq 'FOUND'
      end

      it 'return project' do
        expect(response['result']).to eq({ "customdomain" => "", "descr" => "", "id" => project_id, "title" => "vm" })
      end
    end

    context 'error call' do
      let(:response) { subject.project(-1) }

      before do
        stub_api_request(:project_error, config: config, project_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find project with this 'projectid' parameter"
      end
    end
  end

  describe '#project_export' do
    context 'success call' do
      let(:response) { subject.project_export(project_id) }

      before do
        stub_api_request(:project_export, config: config, project_id: project_id)
      end

      it 'return status FOUND' do
        expect(response['status']).to eq 'FOUND'
      end

      it 'return result' do
        expect(response['result']).to eq(
                                        { "id"             => "000000",
                                          "title"          => "vm",
                                          "descr"          => "",
                                          "customdomain"   => "",
                                          "export_csspath" => "",
                                          "export_jspath"  => "",
                                          "export_imgpath" => "",
                                          "indexpageid"    => "000000",
                                          "page404id"      => "0",
                                          "images"         => [{ "from" => "https://static.tildacdn.com/img/tildafavicon.ico", "to" => "tildafavicon.ico" }],
                                          "htaccess"       => "DirectoryIndex page4310238.html\n\nRewriteEngine On\n\n" }
                                      )
      end
    end

    context 'error call' do
      let(:response) { subject.project_export(-1) }

      before do
        stub_api_request(:project_export_error, config: config, project_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find project with this 'projectid' parameter"
      end
    end

  end

  describe '#pages_list' do
    context 'success call' do
      let(:response) { subject.pages_list(project_id) }

      before do
        stub_api_request(:pages_list, config: config, project_id: project_id)
      end

      it 'return status FOUND' do
        expect(response['status']).to eq 'FOUND'
      end

      it 'return result' do
        expect(response['result']).to eq(
                                        [
                                          {
                                            "id"         => "000000",
                                            "projectid"  => "000000",
                                            "title"      => "Динозавры, насекомые и хиппи",
                                            "descr"      => "This longread contains videos, photographs and short texts.  ",
                                            "img"        => "",
                                            "featureimg" => "",
                                            "alias"      => "",
                                            "date"       => "2018-12-12 10:53:59",
                                            "sort"       => "10",
                                            "published"  => "",
                                            "filename"   => "page4310238.html"
                                          },
                                          {
                                            "id"         => "000001",
                                            "projectid"  => "000000",
                                            "title"      => "Дайте выспаться",
                                            "descr"      => "Пример лендинга для бара или кафе",
                                            "img"        => "",
                                            "featureimg" => "",
                                            "alias"      => "",
                                            "date"       => "2018-12-12 11:16:42",
                                            "sort"       => "20",
                                            "published"  => "",
                                            "filename"   => "page4310481.html"
                                          }
                                        ]
                                      )
      end
    end

    context 'error call' do
      let(:response) { subject.pages_list(-1) }

      before do
        stub_api_request(:pages_list_error, config: config, project_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find project with this 'projectid' parameter"
      end
    end
  end

  describe '#page' do
    context 'success call' do
      let(:response) { subject.page(page_id) }

      before do
        stub_api_request(:page, config: config, page_id: page_id)
      end

      it 'return status FOUND' do
        expect(response['status']).to eq 'FOUND'
      end

      it 'return result' do
        expect(response['result']).to eq({
                                           "id"         => "000000",
                                           "projectid"  => "000000",
                                           "title"      => "Динозавры, насекомые и хиппи",
                                           "descr"      => "This longread contains videos, photographs and short texts.  ",
                                           "img"        => "",
                                           "featureimg" => "",
                                           "alias"      => "",
                                           "date"       => "2018-12-12 10:53:59",
                                           "sort"       => "10",
                                           "published"  => "",
                                           "filename"   => "page4310238.html",
                                           "html"       => "Page not published"
                                         })
      end
    end

    context 'error call' do
      let(:response) { subject.page(-1) }

      before do
        stub_api_request(:page_error, config: config, page_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find page with this 'pageid' parameter"
      end
    end
  end

  describe '#page_full' do
    context 'success call' do
      let(:response) { subject.page_full(page_id) }

      before do
        stub_api_request(:page_full, config: config, page_id: page_id)
      end

      it 'return status FOUND' do
        expect(response['status']).to eq 'FOUND'
      end

      it 'return result' do
        expect(response['result']).to eq({
                                           "id"         => "000000",
                                           "projectid"  => "000000",
                                           "title"      => "Динозавры, насекомые и хиппи",
                                           "descr"      => "This longread contains videos, photographs and short texts.  ",
                                           "img"        => "",
                                           "featureimg" => "",
                                           "alias"      => "",
                                           "date"       => "2018-12-12 10:53:59",
                                           "sort"       => "10",
                                           "published"  => "1544623345",
                                           "filename"   => "page4310238.html",
                                           "html"       => "<!DOCTYPE html><html></html>"
                                         })
      end
    end

    context 'error call' do
      let(:response) { subject.page_full(-1) }

      before do
        stub_api_request(:page_full_error, config: config, page_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find page with this 'pageid' parameter"
      end
    end
  end

  describe '#page_export' do
    context 'success call' do
      let(:response) { subject.page_export(page_id) }

      before do
        stub_api_request(:page_export, config: config, page_id: page_id)
      end

      it 'return status FOUND' do
        expect(response['status']).to eq 'FOUND'
      end

      it 'return result' do
        expect(response['result']).to eq({
                                           "id"         => "000000",
                                           "projectid"  => "000000",
                                           "title"      => "Динозавры, насекомые и хиппи",
                                           "descr"      => "This longread contains videos, photographs and short texts.  ",
                                           "img"        => "",
                                           "featureimg" => "",
                                           "alias"      => "",
                                           "date"       => "2018-12-12 10:53:59",
                                           "sort"       => "10",
                                           "published"  => "1544623345",
                                           "filename"   => "page4310238.html",
                                           "images"     => [
                                             {
                                               "from" => "https://static.tildacdn.com/37ed5fef-6138-40c1-a1d9-838f3c870c04/Untitled1.jpg",
                                               "to"   => "37ed5fef-6138-40c1-a1d9-838f3c870c04__untitled1.jpg"
                                             }
                                           ],
                                           "css"        => [
                                             {
                                               "from" => "https://static.tildacdn.com/css/tilda-grid-3.0.min.css",
                                               "to"   => "tilda-grid-3.0.min.css"
                                             }
                                           ],
                                           "js"         => [
                                             {
                                               "from" => "https://static.tildacdn.com/js/jquery-1.10.2.min.js",
                                               "to"   => "jquery-1.10.2.min.js"
                                             },
                                           ],
                                           "html"       => "<!--allrecords-->"
                                         })
      end
    end

    context 'error call' do
      let(:response) { subject.page_export(-1) }

      before do
        stub_api_request(:page_export_error, config: config, page_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find page with this 'pageid' parameter"
      end
    end
  end

  describe '#page_full_export' do
    context 'success call' do
      let(:response) { subject.page_full_export(page_id) }

      before do
        stub_api_request(:page_full_export, config: config, page_id: page_id)
      end

      it 'return status FOUND' do
        expect(response['status']).to eq 'FOUND'
      end

      it 'return result' do
        expect(response['result']).to eq({
                                           "id"         => "000000",
                                           "projectid"  => "000000",
                                           "title"      => "Динозавры, насекомые и хиппи",
                                           "descr"      => "This longread contains videos, photographs and short texts.  ",
                                           "img"        => "",
                                           "featureimg" => "",
                                           "alias"      => "",
                                           "date"       => "2018-12-12 10:53:59",
                                           "sort"       => "10",
                                           "published"  => "1544623345",
                                           "filename"   => "page4310238.html",
                                           "images"     => [
                                             {
                                               "from" => "https://static.tildacdn.com/37ed5fef-6138-40c1-a1d9-838f3c870c04/Untitled1.jpg",
                                               "to"   => "37ed5fef-6138-40c1-a1d9-838f3c870c04__untitled1.jpg"
                                             }
                                           ],
                                           "css"        => [
                                             {
                                               "from" => "https://static.tildacdn.com/css/tilda-grid-3.0.min.css",
                                               "to"   => "tilda-grid-3.0.min.css"
                                             }
                                           ],
                                           "js"         => [
                                             {
                                               "from" => "https://static.tildacdn.com/js/jquery-1.10.2.min.js",
                                               "to"   => "jquery-1.10.2.min.js"
                                             },
                                           ],
                                           "html"       => "<!DOCTYPE html><html></html>"
                                         })
      end
    end

    context 'error call' do
      let(:response) { subject.page_full_export(-1) }

      before do
        stub_api_request(:page_full_export_error, config: config, page_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find page with this 'pageid' parameter"
      end
    end
  end
end