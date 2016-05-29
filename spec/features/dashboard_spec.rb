require 'spec_helper'

feature 'Loading the dashboard' do
  scenario 'I can see the page header' do
    visit '/'
    expect(page).to have_content 'Hello HookLineAndSinker!'
  end
end
