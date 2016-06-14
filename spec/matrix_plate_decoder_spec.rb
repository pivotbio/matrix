require 'spec_helper'

describe Decoder::MatrixPlateDecoder do
  let(:decoder) { Decoder::MatrixPlateDecoder.new('./spec/data/gsplate-600-color.tiff') }

  it 'can be created' do
    expect { decoder }.to_not raise_error
  end

  it '#codes returns an array' do
    expect(decoder.codes.count(nil)).to eq(35)
  end
end
