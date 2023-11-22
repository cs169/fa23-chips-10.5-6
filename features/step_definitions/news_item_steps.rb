# frozen_string_literal: true

Given(/^I have a representative$/) do
  @representative = Representative.create(name: 'John Doe')
end

When('I login in with Google') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = {
    'provider' => 'google_oauth2',
    'uid'      => '12345',
    'info'     => {
      'name'  => 'Test User',
      'email' => 'test@example.com'
    }
  }
  visit '/login'
  click_button 'Sign in with Google'
end

When(/^I visit the news item page$/) do
  visit representative_news_items_path(@representative.id)
end

When(/^I add a news article$/) do
  click_link 'Add News Article'
end

Then(/^I fill in the form$/) do
  fill_in 'news_item[title]', with: 'Exciting News'
  fill_in 'news_item[link]', with: 'https://example.com'
  fill_in 'news_item[description]', with: 'Example description.'
  select 'John Doe', from: 'news_item[representative_id]'
end

When(/^I save the news item$/) do
  click_button 'Save'
end

Then(/^the item should be displayed$/) do
  expect(page).to have_content('Exciting News')
  expect(page).to have_content('Example description.')
end
