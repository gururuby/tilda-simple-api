RSpec.shared_examples 'invalid credentials error' do |api_request|
  context 'errors' do
    let(:response) { subject.public_send(api_request) }

    before do
      allow(config).to receive(:secret_key).and_return('broken key')
    end

    context 'return error response' do
      before do
        stub_api_request("#{api_request}_error", config: config)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Wrong Secret Key length"
      end
    end

    context 'raising api error' do
      before do
        allow(config).to receive(:raise_api_errors).and_return(true)
        stub_api_request("#{api_request}_error", config: config)
      end

      it 'return Tilda::Simple::Api::Errors::InvalidCredentials' do
        expect{ response }.to raise_error(Tilda::Simple::Api::Errors::InvalidCredentials)
      end
    end
  end
end

RSpec.shared_examples 'project not found error' do |api_request|
  context 'errors' do
    let(:response) { subject.public_send(api_request, -1) }

    context 'return error response' do
      before do
        stub_api_request("#{api_request}_error", config: config, project_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find project with this 'projectid' parameter"
      end
    end

    context 'raising api error' do
      before do
        allow(config).to receive(:raise_api_errors).and_return(true)
        stub_api_request("#{api_request}_error", config: config, project_id: -1)
      end

      it 'return Tilda::Simple::Api::Errors::ProjectNotFound' do
        expect{ response }.to raise_error(Tilda::Simple::Api::Errors::ProjectNotFound)
      end
    end
  end
end

RSpec.shared_examples 'page not found error' do |api_request|
  context 'errors' do
    let(:response) { subject.public_send(api_request, -1) }

    context 'return error response' do
      before do
        stub_api_request("#{api_request}_error", config: config, page_id: -1)
      end

      it 'return status ERROR' do
        expect(response['status']).to eq 'ERROR'
      end

      it 'return error message' do
        expect(response['message']).to eq "Error. Can't find page with this 'pageid' parameter"
      end
    end

    context 'raising api error' do
      before do
        allow(config).to receive(:raise_api_errors).and_return(true)
        stub_api_request("#{api_request}_error", config: config, page_id: -1)
      end

      it 'return Tilda::Simple::Api::Errors::PageNotFound' do
        expect{ response }.to raise_error(Tilda::Simple::Api::Errors::PageNotFound)
      end
    end
  end
end