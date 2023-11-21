# frozen_string_literal: true

Given('there is a representative with a profile') do
  profile = { name: 'Test Representative', ocdid: 'some-ocdid-1', title: 'Governor' }
  @representative = Representative.find_or_create_by(profile)
end

When('the user visits the representative profile page') do
  visit representative_show_path(@representative.id)
end

Then('they should see the representative\'s profile details') do
  expect(page).to have_content(@representative.name)
  expect(page).to have_content(@representative.ocdid)
end
