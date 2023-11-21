# frozen_string_literal: true

Then('I should be redirected') do
  expected_url = 'http://www.example.com/'
  expect(current_url).to start_with(expected_url)
end
