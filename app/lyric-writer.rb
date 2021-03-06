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
    @cookies = cookies
    lazy_init_dictionary
    lazy_init_line_structure
    @dictionary = json_parse(cookies[:dictionary]).sort
    if dictionary_is_valid?
      create_haiku
      create_user_lines
    end
    erb :index
  end

  get '/cookies' do
    cookies[:dictionary] = JSON.dump({})
    cookies[:line_structure] = JSON.dump([])
    "cookies cleared"
  end

  post '/clear_dictionary' do
    cookies[:dictionary] = JSON.dump({})
    redirect '/'
  end

  post '/reset_line_structure' do
    cookies[:line_structure] = JSON.dump([])
    redirect '/'
  end

  post '/add_to_dictionary' do
    # lazy_init_dictionary
    parsed_dictionary = json_parse(cookies[:dictionary])
    phrase = params[:phrase]
    syllables = params[:syllables].to_i
    parsed_dictionary[phrase] = syllables
    cookies[:dictionary] = JSON.dump(parsed_dictionary)
    redirect '/'
  end

  post '/remove_phrase' do
    # lazy_init_dictionary
    parsed_dictionary = json_parse(cookies[:dictionary])
    phrase_to_remove = params[:remove]
    parsed_dictionary = parsed_dictionary.tap { |phrase| phrase.delete(phrase_to_remove) }
    cookies[:dictionary] = JSON.dump(parsed_dictionary)
    redirect '/'
  end

  post '/add_line' do
    # lazy_init_line_structure
    parsed_line_structure = json_parse(cookies[:line_structure])
    new_lines_array = params[:new_line_length].split(" ")
    add_arrays_with_limit(new_lines_array, parsed_line_structure, 200)
    cookies[:line_structure] = JSON.dump(parsed_line_structure)
    redirect '/'
  end

    # start the server if ruby file executed directly
  run! if app_file == $0


  helpers do

    def add_arrays_with_limit(array1, array2, limit)
      array1.each do |num|
        num.to_i < limit ? array2 << num.to_i : array2 << limit
      end
    end

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

    def dictionary_is_valid?
      @dictionary.flatten.include?(1)
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
      @haiku << line_maker(5) << line_maker(7) << line_maker(5)
    end

    def create_user_lines
      @user_lines = []
      line_structure = json_parse(cookies[:line_structure])
      line_structure.each do |number|
        @user_lines << line_maker(number)
      end
    end

    def json_parse(cookies)
      JSON.parse(URI.decode(cookies))
    end

    def lazy_init_dictionary
      cookies[:dictionary] ||= JSON.dump({})
    end

    def lazy_init_line_structure
      cookies[:line_structure] ||= JSON.dump([])
    end

  end

end
