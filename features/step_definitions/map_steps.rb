# frozen_string_literal: true

When(/I click "([^"]*)" on state map/) do |string|
  visit search_representatives_path(string)
end

When(/I click "([^"]*)" on country map/) do |string|
  visit "state/#{string}"
end
