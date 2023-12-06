# frozen_string_literal: true

class CampaignFinance < ApplicationRecord
  def self.propublica_api_to_campaign_finance_params(results)
    campaign_finance_results = []
    results.each do |result|
      name = result['name'].split(', ')
      representative = CampaignFinance.find_or_initialize_by(first_name: name[1], last_name: name[0])
      if representative.new_record?
        representative = CampaignFinance.create(first_name: name[1], last_name: name[0],
                                                total_from_individuals: result['total_from_individuals'],
                                                total_from_pacs:        result['total_from_pacs'],
                                                total_contributions:    result['total_contributions'],
                                                candidate_loans:        result['candidate_loans'],
                                                total_disbursements:    result['total_disbursements'],
                                                total_receipts:         result['total_receipts'],
                                                end_cash:               result['end_cash'],
                                                total_refunds:          result['total_refunds'],
                                                debts_owed:             result['debts_owed'])
        representative.save!
      end
      campaign_finance_results.push(representative)
    end
    campaign_finance_results
  end
end
