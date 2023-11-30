# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinancesController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #search' do
    example_result = {
      'results' => [{
        'relative_uri'           => '/candidates/S4CO00395.json',
        'name'                   => 'GARDNER, CORY',
        'party'                  => 'REP',
        'state'                  => '/races/CO.json',
        'district'               => '00',
        'committee'              => '/committees/C00492454.json',
        'status'                 => 'I',
        'total_from_individuals' => 3_527_890.7,
        'total_from_pacs'        => 1_706_367.74,
        'total_contributions'    => 5_278_858.44,
        'candidate_loans'        => nil,
        'total_disbursements'    => 1_468_278.59,
        'begin_cash'             => 1_701_437.57,
        'end_cash'               => 6_696_586.98,
        'total_refunds'          => 76_948.56,
        'debts_owed'             => nil,
        'date_coverage_from'     => '2019-01-01',
        'date_coverage_to'       => '2019-09-30'
      }]
    }

    it 'assigns @campaign_finances' do
      allow(controller).to receive(:query_propublica_api).and_return(example_result)
      get :search, params: { cycle: '2022', category: 'pac-total' }
      element = assigns(:campaign_finances)[0]
      expect(element.first_name).to eq('CORY')
      expect(element.total_from_pacs).to eq(1_706_367.74)
    end

    it 'renders the search template' do
      allow(controller).to receive(:query_propublica_api).and_return(example_result)
      get :search, params: { cycle: '2022', category: 'pac-total' }
      expect(response).to render_template('campaign_finances/search')
    end
  end

  describe '#query_propublica_api' do
    it 'returns a response from the ProPublica API' do
      response = controller.query_propublica_api('2020', 'pac-total')
      expect(response.class).to eq(Hash)
      expect(response['status']).to eq('OK')
      expect(response['cycle']).to eq(2020)
      expect(response['results'].size).to be > 0
    end

    it 'raises an error if response is not successful' do
      expect do
        controller.query_propublica_api('2021', 'pac-total')
      end.to raise_error(RuntimeError, 'ProPublica API request failed with status 200')
    end
  end
end
