require 'spec_helper'

  def post_json(uri, json)
    post(uri, json, { "CONTENT_TYPE" => "application/json" })
  end

  def create_dummy_data
    Email.create(timestamp: 1432820696, address: "barney@lostmy.name", emailtype: "Shipment", event: "send")
    Email.create(timestamp: 1432820702, address: "tom@lostmy.name", emailtype: "UserConfirmation", event: "click")
    Email.create(timestamp: 1432820704, address: "vitor@lostmy.name", emailtype: "Shipment", event: "open")
  end

  describe 'Posting webhooks to the / route' do
    good_email = {"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}.to_json
    bad_email = {"Address":"barney@lostmy.name","EmailType":12345,"Event":"send","Timestamp":"This should be an int"}.to_json

    it 'returns a successful status code and message when fields are valid' do
      post_json('/', good_email)
      expect(last_response.status).to eql(200)
      expect(last_response.body).to eql('Success! Webhook Data Parsed')
    end

    it 'returns a failing status code and message when fields are invalid or missing' do
      post_json('/', bad_email)
      expect(last_response.status).to eql(400)
      expect(last_response.body).to eql('Data failed validations')
    end

    it 'returns a failing status code and message when no data is provided' do
      post_json('/', {})
      expect(last_response.status).to eql(400)
      expect(last_response.body).to eql('Unable to parse JSON')
    end

    it 'adds a record to the email database when successful' do
      post_json('/', good_email)
      expect(Email.count).to eql(1)
    end

    it 'should correctly store model properties when successful' do
      post_json('/', good_email)
      expect(Email.first.address).to eql("barney@lostmy.name")
    end
  end

  describe 'Getting from the /api/emails route' do

    it 'returns all emails when given no parameters or query' do
      expected_json = [ {"id"=>4, "timestamp"=>1432820696, "address"=>"barney@lostmy.name", "emailtype"=>"Shipment", "event"=>"send"},
                        {"id"=>5, "timestamp"=>1432820702, "address"=>"tom@lostmy.name", "emailtype"=>"UserConfirmation", "event"=>"click"},
                        {"id"=>6, "timestamp"=>1432820704, "address"=>"vitor@lostmy.name", "emailtype"=>"Shipment", "event"=>"open"} ].to_json

      create_dummy_data
      get '/api/emails'
      expect(last_response.status).to eql(200)
      expect(last_response.body).to eql(expected_json)
    end

    it 'returns specific emails when given a valid query' do
      expected_json = [ {"id"=>7, "timestamp"=>1432820696, "address"=>"barney@lostmy.name", "emailtype"=>"Shipment", "event"=>"send"} ].to_json

      create_dummy_data
      get '/api/emails?address=barney@lostmy.name'
      expect(last_response.status).to eql(200)
      expect(last_response.body).to eql(expected_json)
    end
  end
