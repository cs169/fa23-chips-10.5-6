# frozen_string_literal: true

When(/^I sign in with (.+)$/) do |auth_provider|
  OmniAuth.config.test_mode = true

  case auth_provider
  when 'Google'
    OmniAuth.config.mock_auth[:google_oauth2] = {
      'provider' => 'google_oauth2',
      'uid'      => '12345',
      'info'     => {
        'name'  => 'Test User',
        'email' => 'test@example.com'
      }
    }
    click_button 'Sign in with Google'

  when 'GitHub'
    OmniAuth.config.mock_auth[:github] = {
      'provider' => 'github',
      'uid'      => '12345',
      'info'     => {
        'name'  => 'Test User',
        'email' => 'test@example.com'
      }
    }
    click_button 'Sign in with GitHub'

  else
    raise "Unsupported authentication provider: #{auth_provider}"
  end
end

Then('I should be redirected to the home page') do
  expect(page).to have_current_path('/')
end

Given('I am logged in') do
  step 'I am on the login page'
  step 'I sign in with Google'
  step 'I should be redirected to the home page'
end

Then('I should see a login profile') do
  expect(page).to have_content('Your Profile')
end

Then('I can logout') do
  click_link 'Logout'
end

And('I should no longer be logged in') do
  step 'I am on the login page'
  expect(page).to have_content('Sign In')
end
