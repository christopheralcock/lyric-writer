require 'sinatra/base'
require 'sinatra/cookies'
require 'rubygems'
require_relative 'models/phrase'
require 'json'
require 'uri'
require_relative 'models/hash'

class LyricWriter < Sinatra::Base
  helpers Sinatra::Cookies


  get '/' do
    cookies[:dictionary] ||= JSON.dump({})
    @dictionary = JSON.parse(URI.decode(cookies[:dictionary]))
    create_haiku
    erb :index
  end

  get '/cookies' do
    cookies[:dictionary] = JSON.dump({"hello"=>2, "i"=>1, "have"=>1, "made"=>1, "a"=>1, "small"=>1, "list"=>1, "of"=>1, "words"=>1, "for"=>1, "debugging"=>3, "reasons"=>2, "long phrase to demonstrate i can put long phrases in"=>13})
    "cookies set to a sensible set as of 13th feb 2016"
  end

  post '/' do
    cookies[:dictionary] ||= JSON.dump({})
    parsed = JSON.parse(URI.decode(cookies[:dictionary]))
    p "parsed object: #{parsed}"
    phrase = params[:phrase]
    syllables = params[:syllables].to_i
    parsed[phrase] = syllables
    p "parsed object after adding page contents: #{parsed}"
    cookies[:dictionary] = JSON.dump(parsed)
    redirect '/'
  end


    # start the server if ruby file executed directly
  run! if app_file == $0


  helpers do

    def sampler(line_length)
      @sample_line = ""
      sample_line_array = []
      sample_line_length = line_length
      @dictionary.shuffle!
      @dictionary.each do |phrase, syllables|
        if sample_line_length >= syllables
          sample_line_array << phrase
          sample_line_length -= syllables
        end
      end
      sample_line_array.each do |word|
        @sample_line += " #{word}"
      end
      @sample_line
    end

    def create_haiku
      @haiku = []
      @haiku << sampler(5)
      @haiku << sampler(7)
      @haiku << sampler(5)
    end


  end

end
