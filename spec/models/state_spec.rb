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
      it 'returns a standardized fips code' do
        expect(described_class.new(fips_code: 6).std_fips_code).to eq('06')
        expect(described_class.new(fips_code: 42).std_fips_code).to eq('42')
        expect(described_class.new(fips_code: 123).std_fips_code).to eq('123')
      end
    end
  end
end
