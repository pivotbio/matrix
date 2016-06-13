require 'spec_helper'

describe Decoder do

  let(:decoder) { Decoder.new }

  it 'can be created' do
    expect { decoder }.to_not raise_error
  end

  it '#codes returns an array' do
    expect(decoder.codes).to be_a(Array)
  end
end
