ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'app/lyric-writer.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app, _ = Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__))


class LyricWriterWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  LyricWriter.new
end
