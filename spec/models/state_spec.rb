# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'associations' do
    it 'has many counties' do
      expect(described_class.reflect_on_association(:counties).macro).to eq(:has_many)
    end
  end

  describe 'methods' do
    describe '#std_fips_code' do
      it 'returns a standardized FIPS code with leading zeros' do
        state = described_class.new(fips_code: 6)
        expect(state.std_fips_code).to eq('06')
      end

      it 'returns a two-digit FIPS code as is' do
        state = described_class.new(fips_code: 42)
        expect(state.std_fips_code).to eq('42')
      end

      it 'returns a three-digit FIPS code as is' do
        state = described_class.new(fips_code: 123)
        expect(state.std_fips_code).to eq('123')
      end
    end
  end
end
