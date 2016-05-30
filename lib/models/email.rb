class Email
  include DataMapper::Resource

  property :id, Serial, required: true
  property :timestamp, Integer, required: true
  property :address, String, required: true
  property :emailtype, String, required: true
  property :event, String, required: true

end
