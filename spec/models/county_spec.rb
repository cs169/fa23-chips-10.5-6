# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  describe 'associations' do
    it 'belongs to state' do
      expect(described_class.reflect_on_association(:state).macro).to eq(:belongs_to)
    end
  end

  describe 'methods' do
    describe '#std_fips_code' do
      it 'returns a standardized FIPS code with leading zeros' do
        county = described_class.new(fips_code: 6)
        expect(county.std_fips_code).to eq('006')
      end

      it 'returns a two-digit FIPS code as is' do
        county = described_class.new(fips_code: 42)
        expect(county.std_fips_code).to eq('042')
      end

      it 'returns a three-digit FIPS code as is' do
        county = described_class.new(fips_code: 123)
        expect(county.std_fips_code).to eq('123')
      end
    end
  end
end
