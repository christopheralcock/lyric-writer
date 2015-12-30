require 'sinatra/base'
require 'sinatra/flash'
require 'rubygems'
require_relative 'models/phrase'

class LyricWriter < Sinatra::Base

  get '/' do
    @phrases = Phrase.all
    erb :index
  end

  post '/phrases' do
    Phrase.create(phrase: params[:phrase], syllables: params[:syllables], stress_pattern: params[:stress_pattern])
    redirect to('/')
  end

    # start the server if ruby file executed directly
  run! if app_file == $0
end
