# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinance, type: :model do
  describe '#propublica_api_to_campaign_finance_params' do
    let(:api_results) do
      [
        {
          'name'                   => 'Doe, John',
          'total_from_individuals' => 1000,
          'total_from_pacs'        => 500,
          'total_contributions'    => 1500,
          'candidate_loans'        => 200,
          'total_disbursements'    => 1200,
          'total_receipts'         => 1600,
          'end_cash'               => 400,
          'total_refunds'          => 50,
          'debts_owed'             => 100
        }
      ]
    end

    it 'creates or updates CampaignFinance records from API results' do
      campaign_finance_results = described_class.propublica_api_to_campaign_finance_params(api_results)

      expect(campaign_finance_results).to be_an(Array)
      expect(campaign_finance_results.length).to eq(api_results.length)
      expect(campaign_finance_results).to all(be_a(described_class))
      expect(campaign_finance_results).to all(be_persisted)
    end

    it 'correctly sets attributes for CampaignFinance records' do
      described_class.propublica_api_to_campaign_finance_params(api_results)
      representative = described_class.find_by(first_name: 'John', last_name: 'Doe')

      expect(representative).not_to be_nil
      expect(representative.total_from_individuals).to eq(1000)
      expect(representative.candidate_loans).to eq(200)
    end

    it 'does not create duplicate CampaignFinance records' do
      described_class.propublica_api_to_campaign_finance_params(api_results)
      count_before = described_class.count

      described_class.propublica_api_to_campaign_finance_params(api_results)
      count_after = described_class.count
      expect(count_after).to eq(count_before)
    end
  end
end
