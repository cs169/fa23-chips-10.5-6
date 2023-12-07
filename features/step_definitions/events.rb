# frozen_string_literal: true

When(/I visit event "([^"]*)"/) do |string|
  visit events_path(string)
end

When(/I visit my event "([^"]*)"/) do |string|
  visit edit_my_event_path(string)
end

When(/I create an event/) do
  visit new_my_event_path
end
