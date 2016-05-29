require 'data_mapper'
require 'dm-postgres-adapter'

class Email
  include DataMapper::Resource

  property :id,          Serial
  property :timestamp,   Integer
  property :address,     String
  property :emailtype,   String
  property :event,       String

end

DataMapper.setup(:default, "postgres://localhost/hls_test")
DataMapper.finalize
DataMapper.auto_upgrade!
