require 'json'

class Tube < ActiveRecord::Base
end

get '/' do 
  logger.info `echo $PATH`
  erb :index
end

post '/' do
  @codes = decode_plate(params['uploaded_data'][:tempfile])
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