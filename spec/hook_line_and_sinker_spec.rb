require 'spec_helper'

  # feature 'Posting to the / route' do
  #   scenario 'creates DB entries for incoming emails' do
  #     email = {"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}
  #     post "/", :body => email.to_json
  #     expect(response.body).to eql('1')
  #   end
  # end
  #
  # feature 'Viewing email list' do
  #   scenario 'I can see existing links on the links page' do
  #     Email.create(address: "barney@lostmy.name", emailtype: "Shipment", event: "send", timestamp: 1432820696)
  #     visit '/emails'
  #     expect(page.status_code).to eq 200
  #     expect(page).to have_content("barney@lostmy.name")
  #   end
  # end
