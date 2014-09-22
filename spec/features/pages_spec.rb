require 'rails_helper'

feature 'Navigating between pages', js: true do
  scenario 'navigating to "browse" page' do
    visit '/'
    expect(find('.page-header')).to have_content('Dashboard')

    click_on 'Browser'
    expect(find('.page-header')).to have_content('Browser')
  end
end
