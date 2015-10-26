require 'spec_helper'

describe Scan, focus: true do
  let(:scan) { Scan.new filename: 'test' }

  it 'can be created' do
    expect(scan).to_not be_nil
  end

  it 'can be saved' do
    expect(scan.id).to be_nil
    expect(scan.save.id).to_not be_nil
    expect(Scan[scan.id]).to be_a(Scan)
  end

  it '#filename stores a string' do
    scan.save.reload
    expect(scan.filename).to be_a(String)
  end

  it '#created_at stores a DateTime' do
    scan.save.reload
    expect(scan.created_at).to be_a(Time)
  end

  it '#created_at can be overriden before save' do
    the_time = Time.now
    scan.created_at = the_time
    scan.save
    expect(scan.reload.created_at).to eq(the_time)
  end

  it 'saving a Scan increments Scan#count' do
    start_count = Scan.count
    scan.save
    expect(Scan.count).to eq(start_count + 1)
  end

  it 'Scan#create saves a new scan' do
    expect(Scan.create filename: 'test').to be_a(Scan)
    expect(Scan.create(filename: 'test').id).to_not be_nil
  end

  it 'Scan#create raises an error if #filename is empty' do
    expect { Scan.create }.to raise_error(Sequel::NotNullConstraintViolation)
  end
end
