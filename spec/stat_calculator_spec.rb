require 'spec_helper'

describe StatCalculator do

  def create_dummy_data
    Email.create(timestamp: 1432820696, address: "barney@lostmy.name", emailtype: "Shipment", event: "send")
    Email.create(timestamp: 1432820702, address: "tom@lostmy.name", emailtype: "UserConfirmation", event: "click")
    Email.create(timestamp: 1432820704, address: "vitor@lostmy.name", emailtype: "Shipment", event: "open")
    Email.create(timestamp: 1432820704, address: "vitor@lostmy.name", emailtype: "Shipment", event: "send")
    Email.create(timestamp: 1432820702, address: "tom@lostmy.name", emailtype: "UserConfirmation", event: "send")
    Email.create(timestamp: 1432820696, address: "barney@lostmy.name", emailtype: "Shipment", event: "open")
  end

expected_response = {
  totals: {
    send: 3,
    open: 2,
    click: 1
  },
  opened_per_type: {
    shipment: 2
  },
  clicked_per_type: {
    userconfirmation: 1
  }
}

  describe 'calculate' do
    it 'returns statistics object' do
      create_dummy_data
      @calculator = StatCalculator.new
      expect(@calculator.calculate).to eql(expected_response)
    end
  end

end
