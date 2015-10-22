require 'rubygems'
require 'sinatra'
require 'active_record'
require 'fileutils'

set :root, File.dirname(__FILE__)
require './app.rb'

enable :logging

run Sinatra::Application
