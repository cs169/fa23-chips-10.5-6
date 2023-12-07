# frozen_string_literal: true

Given(/^I have a representative$/) do
  @representative = Representative.create(name: 'John Doe', title: 'President')
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

Given(/^I visit the news item page$/) do
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
  select 'Free Speech', from: 'news_item[issue]'
end

When(/^I save the news item$/) do
  click_button 'Save'
end

Then(/^the item should be displayed$/) do
  expect(page).to have_content('Exciting News')
  expect(page).to have_content('Example description.')
  expect(page).to have_content('Free Speech')
end

Given(/^I am viewing a created news item$/) do
  step 'I add a news article'
  step 'I fill in the form'
  step 'I save the news item'
  step 'the item should be displayed'
end

When(/^I click the representative's name$/) do
  click_link 'John Doe'
end

Then(/^their profile page is displayed$/) do
  expect(page).to have_content('Representative Information')
  expect(page).to have_content(@representative.name)
  expect(page).to have_content(@representative.title)
end
