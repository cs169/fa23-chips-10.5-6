# rubocop:disable RSpec/VerifiedDoubles
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    before do
      described_class.find_or_create_by(name: 'Gavin Newsom', ocdid: 'some-ocdid-1', title: 'Governor')
      described_class.find_or_create_by(name: 'Alexandria Ocasio-Cortez', ocdid: 'some-ocdid-2', title: 'Congresswoman')
    end

    let(:new_rep_info) do
      double(
        'RepInfo',
        officials: [
          double('Official', name: 'Gavin Newsom', address: nil, party: 'party1'),
          double('Official', name: 'Alexandria Ocasio-Cortez', address: nil, party: 'party2'),
          double('Official', name: 'New Representative',
address: [double(line1: 'Example Street', state: 'CA', zip: '94704', city: 'Berkeley')], party: nil)
        ],
        offices:   [
          double('Office', name: 'Governor', division_id: 'some-ocdid-1', official_indices: [0]),
          double('Office', name: 'Congresswoman', division_id: 'some-ocdid-2', official_indices: [1]),
          double('Office', name: 'New Title', division_id: 'some-ocdid-3', official_indices: [2])
        ]
      )
    end

    it 'adds a new representative without creating duplicates' do
      expect { described_class.civic_api_to_representative_params(new_rep_info) }
        .to change(described_class, :count).by(1)

      expect(described_class.find_by(name: 'Gavin Newsom').title).to eq('Governor')
      expect(described_class.find_by(name: 'Alexandria Ocasio-Cortez').title).to eq('Congresswoman')
    end

    it 'instantiates additional properties for a representative if applicable' do
      described_class.civic_api_to_representative_params(new_rep_info)
      expect(described_class.find_by(name: 'New Representative').city).to eq('Berkeley')
      expect(described_class.find_by(name: 'New Representative').state).to eq('CA')
      expect(described_class.find_by(name: 'New Representative').zip).to eq('94704')
      expect(described_class.find_by(name: 'New Representative').address).to eq('Example Street')
    end
  end
end
# rubocop:enable RSpec/VerifiedDoubles
