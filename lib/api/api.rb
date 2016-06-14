require 'json'

module Decoder
  class API < Sinatra::Base
    get '/' do
      'example usage'
    end

    post '/' do
      MatrixPlateDecoder.new(params[:image][:tempfile].path).codes.to_json
    end
  end
end
