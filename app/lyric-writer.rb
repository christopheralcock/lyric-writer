require 'sinatra/base'
require 'sinatra/flash'
require 'rubygems'

class LyricWriter < Sinatra::Base

  get '/' do
    erb :index
  end


  post '/phrases/new' do
    redirect '/'
    p params[:phrase]
  end

    # start the server if ruby file executed directly
  run! if app_file == $0
end
