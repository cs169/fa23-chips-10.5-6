# frozen_string_literal: true

require 'faraday'
require 'json'

class CampaignFinancesController < ApplicationController
  def index; end

  def search
    cycle = params[:cycle]
    @category = params[:category]
    response = query_propublica_api(cycle, @category)
    results = response['results']
    @campaign_finances = CampaignFinance.propublica_api_to_campaign_finance_params(results)
    render 'campaign_finances/search'
  end

  def query_propublica_api(cycle, category)
    url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"
    headers = { 'X-API-Key' => '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA' }

    conn = Faraday.new do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get(url, nil, headers)
    json_response = JSON.parse(response.body)
    raise "ProPublica API request failed with status #{response.status}" if json_response['status'] != 'OK'

    json_response
  end
end
