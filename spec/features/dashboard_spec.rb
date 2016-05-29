require 'spec_helper'

feature 'Loading the dashboard' do
  scenario 'I can see the page header' do
    visit '/'
    expect(page).to have_content 'Hello HookLineAndSinker!'
  end
end

feature 'Viewing email list' do
  scenario 'I can see existing links on the links page' do
    Email.create(address: "barney@lostmy.name", emailtype: "Shipment", event: "send", timestamp: 1432820696)
    visit '/emails'
    expect(page.status_code).to eq 200
    expect(page).to have_content("barney@lostmy.name")
  end
end
