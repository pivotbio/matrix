require 'json'

module Decoder
  class API < Sinatra::Base

    configure do
      set :port, 6969
    end

    get '/' do
      'example usage'
    end

    post '/' do
      image_path = params[:image][:tempfile].path
      timeout = params[:timeout]
      MatrixPlateDecoder.new(image_path, timeout: timeout).codes.to_json
    end
  end
end
