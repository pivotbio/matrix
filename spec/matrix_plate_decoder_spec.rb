require 'spec_helper'

describe Decoder::GSPlateDecoder do
  let(:decoder) { Decoder::GSPlateDecoder.new('./spec/data/600-dpi-1shotplate.jpeg') }

  it 'can be created' do
    expect { decoder }.to_not raise_error
  end

  it '#codes returns an array' do
    expect(decoder.codes.count(nil)).to eq(7)
  end
end
