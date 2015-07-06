require 'rails_helper'

RSpec.feature 'Shorten URL', type: :feature do
  background { visit root_path }

  scenario 'when entering a valid url', js: true do
    fill_in 'short_url_original_url', with: 'example.com'
    click_button 'Shorten'

    expect(page).to have_content 'Short URL was successfully created.'
    expect(page).to have_content 'Test Short Link'
    expect(page).not_to have_button 'Shorten'
    expect(find_field('short_url_original_url').value).to match(/127.0.0.1/)

    fill_in 'short_url_original_url', with: 'example.com/test'
    expect(page).not_to have_content 'Test Short Link'
    expect(page).to have_button 'Shorten'
  end

  scenario 'when entering an invalid url', js: true do
    fill_in 'short_url_original_url', with: 'example'
    click_button 'Shorten'
    expect(page).to have_content 'Could not create short URL.'
    expect(page).to have_content 'does not look like a URL'
  end
end
