require 'spec_helper'

describe Decoder::API do
  include Rack::Test::Methods

  let(:upload) { Rack::Test::UploadedFile.new('./spec/data/600-dpi-1shotplate.jpeg', 'image/jpeg') }

  def app
    Decoder::API
  end

  it 'has a home page' do
    get('/')
    expect(last_response).to be_ok
  end

  it 'put / takes an image and returns a JSON array' do
    post('/', image: upload)
    expect(last_response).to be_ok
    expect { JSON.parse(last_response.body) }.to_not raise_error
    expect(JSON.parse(last_response.body)).to be_a(Array)
  end
end
