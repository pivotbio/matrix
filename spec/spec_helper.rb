$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

ENV['RACK_ENV'] = 'test'

Bundler.require :test, :development

require 'decoder'
