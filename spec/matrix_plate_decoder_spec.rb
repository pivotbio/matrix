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
    skip('this fails')
    expect(decoder.codes.values.count(nil)).to eq(7)
  end
end

describe PlateWell do
  let(:plate_well) { PlateWell.new 'A', 1 }

  it 'can be created' do
    expect{ plate_well }.to_not raise_error
  end

  it '#row returns row' do
    expect(plate_well.row).to eq('A')
  end

  it '#column returns column' do
    expect(plate_well.column).to eq(1)
  end

  it '#to_s returns #{row}#{column}' do
    expect(plate_well.to_s).to eq('A1')
  end

  describe 'comparator operator' do
    it 'correctly defines equal' do
      expect(plate_well <=> plate_well).to eq(0)
    end

    it 'sorts by row first' do
      a = PlateWell.new 'A', 1
      b = PlateWell.new 'B', 1
      expect(a <=> b).to eq(-1)

      a = PlateWell.new 'B', 1
      b = PlateWell.new 'A', 1
      expect(a <=> b).to eq(1)
    end

    it 'sorts by column second' do
      a = PlateWell.new 'A', 1
      b = PlateWell.new 'A', 2
      expect(a <=> b).to eq(-1)

      a = PlateWell.new 'A', 2
      b = PlateWell.new 'A', 1
      expect(a <=> b).to eq(1)
    end
  end
end
