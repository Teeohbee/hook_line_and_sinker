require 'spec_helper'

describe 'Email' do
  it 'should add record to database' do
    email = Email.new   timestamp: 1432820696,
                        address: "barney@lostmy.name",
                        emailtype: "Shipment",
                        event: "send"
    email.save
    expect(Email.count).to eql(1)
  end

  it 'should correctly store model properties' do
    email = Email.new   timestamp: 1432820696,
                        address: "barney@lostmy.name",
                        emailtype: "Shipment",
                        event: "send"
    email.save
    expect(Email.first.address).to eql("barney@lostmy.name")
  end

  it 'should respect datamapper requirement validations' do
    email = Email.new   timestamp: 1432820696,
                        emailtype: "Shipment",
                        event: "send"
    expect(email.valid?).to eql(false)
  end
end
