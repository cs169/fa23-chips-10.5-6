# frozen_string_literal: true

When(/^I sign in with (.+)$/) do |auth_provider|
  OmniAuth.config.test_mode = true

  auth_config = {
    'provider' => '',
    'uid'      => '12345',
    'info'     => {
      'name'  => 'Test User',
      'email' => 'test@example.com'
    }
  }
  auth = ''

  case auth_provider
  when 'Google'
    auth = 'google_oauth2'
  when 'GitHub'
    auth = 'github'
  else
    raise "Unsupported authentication provider: #{auth_provider}"
  end
  auth_config[:provider] = auth
  OmniAuth.config.mock_auth[auth.to_sym] = auth_config
  click_button "Sign in with #{auth_provider}"
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
