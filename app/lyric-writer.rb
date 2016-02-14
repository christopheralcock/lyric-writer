require 'sinatra/base'
require 'sinatra/cookies'
require 'rubygems'
require_relative 'models/phrase'
require 'json'
require 'uri'
require_relative 'models/hash'

class LyricWriter < Sinatra::Base
  helpers Sinatra::Cookies


#TEST

  get '/' do
    cookies[:dictionary] ||= JSON.dump({})
    @dictionary = JSON.parse(URI.decode(cookies[:dictionary]))
    create_haiku
    create_user_lines
    erb :index
  end

  post '/reset' do
    cookies[:dictionary] = JSON.dump({"here"=>1, "words"=>1, "are"=>1, "but"=>1, "patterns"=>2, "to be"=>2, "played"=>1, "with"=>1})
    cookies[:line_structure] = JSON.dump([0])
    p cookies
    redirect '/'
  end

  post '/add_to_dictionary' do
    cookies[:dictionary] ||= JSON.dump({})
    parsed_dictionary = JSON.parse(URI.decode(cookies[:dictionary]))
    phrase = params[:phrase]
    syllables = params[:syllables].to_i
    parsed_dictionary[phrase] = syllables
    cookies[:dictionary] = JSON.dump(parsed_dictionary)
    redirect '/'
  end

  post '/add_line' do
    cookies[:line_structure] ||= JSON.dump([0])
    parsed_line_structure = JSON.parse(URI.decode(cookies[:line_structure]))
    line_length = params[:new_line_length].to_i
    parsed_line_structure << line_length
    cookies[:line_structure] = JSON.dump(parsed_line_structure)
    redirect '/'
  end


    # start the server if ruby file executed directly
  run! if app_file == $0


  helpers do

    def line_maker(line_length)
      line_array = []
      line_filler(line_length, line_array)
      array_to_text(line_array)
    end

    def line_filler(line_length, line_array)
      while line_length > 0 do
        dictionary = @dictionary.shuffle
        dictionary.each do |phrase, syllables|
          if line_length >= syllables
            line_array << phrase
            line_length -= syllables
          end
        end
      end
    end

    def array_to_text(line_array)
      line = ""
      line_array.each do |word|
        line += " #{word}"
      end
      line
    end

    def create_haiku
      @haiku = []
      @haiku << line_maker(5)
      @haiku << line_maker(7)
      @haiku << line_maker(5)
    end

    def create_user_lines
      @user_lines = []
      line_structure = JSON.parse(URI.decode(cookies[:line_structure]))
      line_structure.each do |number|
        @user_lines << line_maker(number)
      end
    end


  end

end
