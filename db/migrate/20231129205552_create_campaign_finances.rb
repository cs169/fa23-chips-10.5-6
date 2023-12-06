# frozen_string_literal: true

class CreateCampaignFinances < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_finances do |t|
      t.string :first_name
      t.string :last_name
      t.float :total_from_individuals
      t.float :total_from_pacs
      t.float :total_contributions
      t.float :candidate_loans
      t.float :total_disbursements
      t.float :total_receipts
      t.float :end_cash
      t.float :total_refunds
      t.float :debts_owed
      t.timestamps null: false
    end
  end
end
