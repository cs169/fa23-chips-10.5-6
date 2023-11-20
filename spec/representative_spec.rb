require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    it 'does not create duplicate entries for existing representatives' do
      Representative.find_or_create_by(name: 'Gavin Newsom', ocdid: 'some-ocdid-1', title: 'Governor')
      Representative.find_or_create_by(name: 'Alexandria Ocasio-Cortez', ocdid: 'some-ocdid-2', title: 'Congresswoman')

      new_rep_info = double(
        officials: [
          double(name: 'Gavin Newsom'),
          double(name: 'Alexandria Ocasio-Cortez'),
          double(name: 'New Representative')
        ],
        offices: [
          double(name: 'Governor', division_id: 'some-ocdid-1', official_indices: [0]),
          double(name: 'Congresswoman', division_id: 'some-ocdid-2', official_indices: [1]),
          double(name: 'New Title', division_id: 'some-ocdid-3', official_indices: [2])
        ]
      )

      expect {
        Representative.civic_api_to_representative_params(new_rep_info)
      }.to change(Representative, :count).by(1) # Expecting only one new representative to be added

      expect(Representative.find_by(name: 'Gavin Newsom').title).to eq('Governor')
      expect(Representative.find_by(name: 'Alexandria Ocasio-Cortez').title).to eq('Congresswoman')
    end
  end
end
