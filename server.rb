require 'json'

class Tube < ActiveRecord::Base
end

get '/' do 
  logger.debug "Here"
  erb :index
end

get '/upload' do
  codes = decode_plate('Scan.tiff')
end


helpers do
  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
end