#!/usr/bin/env ruby

require 'bundler'
Bundler.require

get '/' do
  logger.info `echo $PATH`
  erb :index
end

post '/' do
  unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
    return erb :index
  end
  File.open("tmp/scan.tiff", "wb") { |f| f.write(tmpfile.read) }

  @codes = decode_plate("tmp/scan.tiff")
  @letters = ['','A','B','C','D','E','F','G','H']
  # @codes is: (A12-H12, A11-H11, etc)
  erb :results
end


helpers do
  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
end
