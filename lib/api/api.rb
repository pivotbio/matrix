require 'json'

module Decoder
  class API < Sinatra::Base

    configure do
      set :port, 6969
    end

    get '/' do
      erb :index
    end

    post '/' do
      image_path = params[:image][:tempfile].path
      timeout = params[:timeout]
      @codes = MatrixPlateDecoder.new(image_path, timeout: timeout).codes
      erb :index
    end
  end
end
