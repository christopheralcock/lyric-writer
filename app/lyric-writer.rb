require 'sinatra/base'
require 'sinatra/flash'
require 'rubygems'

class LyricWriter < Sinatra::Base

  get '/' do
    p "Please tell me a phrase you want to incorporate in your lyrics"
  end

    # start the server if ruby file executed directly
  run! if app_file == $0
end
