ENV['RACK_ENV'] = 'test'
require 'bundler'
Bundler.require :test

require './environment.rb'

Sequel.extension :migration

RSpec.configure do |config|
end
