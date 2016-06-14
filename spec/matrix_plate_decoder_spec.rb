require 'spec_helper'

describe Decoder::MatrixPlateDecoder do
  let(:decoder) { Decoder::MatrixPlateDecoder.new('./spec/data/600-dpi-1shotplate.jpeg') }

  it 'can be created' do
    expect { decoder }.to_not raise_error
  end

  it 'takes a parameter :timeout' do
    decoder = Decoder::MatrixPlateDecoder.new('./spec/data/600-dpi-1shotplate.jpeg', timeout: 10)
    expect(decoder.codes).to be_a(Array)
  end

  it '#codes returns an array' do
    expect(decoder.codes.count(nil)).to eq(7)
  end
end
