#!/usr/bin/env ruby

require 'bundler'
Bundler.require

set :root, File.dirname(__FILE__)

enable :logging

require './lib/decode_plate.rb'


get '/' do
  logger.info `echo $PATH`
  erb :index
end

post '/' do
  unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
    return erb :index
  end

  filename = File.join('uploads', "#{Time.now.to_i}.tiff")

  File.open(filename, "wb") { |f| f.write(tmpfile.read) }

  begin
    @codes = decode_plate(filename)
    @letters = ['','A','B','C','D','E','F','G','H']
  rescue DecodeError => @message
    erb :error
  else
    erb :results
  end
end


helpers do
  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
end
