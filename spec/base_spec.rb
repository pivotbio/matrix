require 'spec_helper'

describe Decoder::Base do

  let(:decoder) { Decoder::Base.new('./spec/data/600-dpi-gsplate.jpeg') }

  it 'can be created' do
    expect { decoder }.to_not raise_error
  end

  it '#codes raises a NotImpelementedError' do
    expect { decoder.codes }.to raise_error(NotImplementedError)
  end
end
