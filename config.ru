require 'rubygems'
require 'sinatra'
require 'active_record'

set :root, File.dirname(__FILE__)
require './server'
require './decode'

enable :logging

run Sinatra::Application
