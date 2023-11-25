# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  describe 'associations' do
    it 'belongs to state' do
      expect(described_class.reflect_on_association(:state).macro).to eq(:belongs_to)
    end
  end

  describe 'methods' do
    it 'returns a code standardized for counties' do
      expect(described_class.new(fips_code: 8).std_fips_code).to eq('008')
      expect(described_class.new(fips_code: 37).std_fips_code).to eq('037')
    end
  end
end
