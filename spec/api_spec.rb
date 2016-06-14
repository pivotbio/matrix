require 'spec_helper'

describe Decoder::API do
  include Rack::Test::Methods

  let(:upload) { Rack::Test::UploadedFile.new('./spec/data/600-dpi-1shotplate.jpeg', 'image/jpeg') }

  def app
    Decoder::API
  end

  it 'has a home page', focus: true do
    get('/')
    expect(last_response).to be_ok
  end

  it 'put / takes an image' do
    post('/', image: upload)
    expect(last_response).to be_ok
  end

  it 'put / takes a timeout attribute' do
    post('/', image: upload, timeout: 10)
    expect(last_response).to be_ok
  end
end
