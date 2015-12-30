require 'data_mapper'
require 'dm-postgres-adapter'

class Phrase

  include DataMapper::Resource

  property :id,             Serial
  property :phrase,         String
  property :syllables,      Integer
  property :stress_pattern, String


end

DataMapper.setup(:default, "postgres://localhost/lyrics_writer")
DataMapper.finalize
DataMapper.auto_upgrade!
