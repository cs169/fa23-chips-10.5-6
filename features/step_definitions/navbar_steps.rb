# frozen_string_literal: true

Then('I should see a link to {string}') do |link_text|
  expect(page).to have_link(link_text)
end

When('I click the {string} link') do |link_text|
  click_link link_text
end

Then('I should be on the {string} page') do |page_name|
  case page_name.downcase
  when 'home'
    expect(current_path).to eq(root_path)
  when 'representatives'
    expect(current_path).to eq(representatives_path)
  when 'campaign finances'
    expect(current_path).to eq(campaign_finances_path)
  when 'login'
    expect(current_path).to eq(login_path)
  else
    raise "Unknown page name: #{page_name}"
  end
end
