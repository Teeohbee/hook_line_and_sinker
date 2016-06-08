require 'spec_helper'
require 'json'

  describe 'Posting to the / route' do
    it 'creates DB entries for incoming emails' do
      email = {"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}
      json = email.to_json
      post_json('/', json)
      expect(last_response.status).to eql(200)
      expect(last_response.body.to_s).to eql('Webhook Data Parsed')
    end
  end

  def post_json(uri, json)
    post(uri, json, { "CONTENT_TYPE" => "application/json" })
  end
