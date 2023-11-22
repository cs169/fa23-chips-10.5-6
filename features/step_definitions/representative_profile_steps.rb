# frozen_string_literal: true

Given('there is a representative with a profile') do
  profile = { name: 'Joseph R. Biden', ocdid: 'some-ocdid-1', title: 'President',
              party: 'Democratic', zip: '20500',
              address: '1600 Pennsylvania Avenue Northwest', city: 'Washington', state: 'DC' }

  @representative = Representative.find_or_create_by(profile)
end

When('the user visits the representative profile page') do
  visit representative_show_path(@representative.id)
end

Then('they should see the representative\'s profile details') do
  expect(page).to have_content(@representative.name)
  expect(page).to have_content(@representative.ocdid)
  expect(page).to have_content(@representative.title)
  expect(page).to have_content(@representative.party)
  expect(page).to have_content(@representative.zip)
  expect(page).to have_content(@representative.address)
  expect(page).to have_content(@representative.city)
  expect(page).to have_content(@representative.state)
end
