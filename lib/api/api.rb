require 'json'

module Decoder
  class API < Sinatra::Base
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
