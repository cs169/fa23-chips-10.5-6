# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it 'belongs to county' do
      expect(described_class.reflect_on_association(:county).macro).to eq(:belongs_to)
    end
  end

  describe 'methods' do
    describe '#county_names_by_id' do
      it 'returns an empty hash if county or state is nil' do
        event = described_class.new
        expect(event.county_names_by_id).to eq({})
      end
    end
  end
end
