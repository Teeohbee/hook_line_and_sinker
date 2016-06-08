require 'spec_helper'

  describe 'Posting to the / route' do
    good_email = {"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}.to_json
    bad_email = {"Address":"barney@lostmy.name","EmailType":12345,"Event":"send","Timestamp":"This should be an int"}.to_json

    it 'returns a successful status code and message when fields are valid' do
      post_json('/', good_email)
      expect(last_response.status).to eql(200)
      expect(last_response.body.to_s).to eql('Webhook Data Parsed')
    end

    it 'returns a failing status code and message when fields are invalid or missing' do
      post_json('/', bad_email)
      expect(last_response.status).to eql(400)
      expect(last_response.body.to_s).to eql('Data failed validations')
    end

    it 'returns a failing status code and message when no data is provided' do
      post_json('/', {})
      expect(last_response.status).to eql(400)
      expect(last_response.body.to_s).to eql('No Data Provided')
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

  def post_json(uri, json)
    post(uri, json, { "CONTENT_TYPE" => "application/json" })
  end
