require './app.rb'

Bundler.require :test

RSpec.configure do |config|
  config.before(:each) do
    system 'rm -rf tmp/*.tif'
    system 'rm -rf tmp/*.tiff'
  end
end
