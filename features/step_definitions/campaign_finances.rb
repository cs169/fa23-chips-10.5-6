# frozen_string_literal: true

Then(/^I fill in the search form$/) do
  select '2020', from: 'cycle'
  select 'Debts Owed', from: 'category'
end
