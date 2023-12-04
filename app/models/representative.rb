# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  # rubocop:disable Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength
  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      street_temp = ''
      city_temp = ''
      state_temp = ''
      zip_temp = ''
      party_temp = ''
      photo_url_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
          photo_url_temp = official.photo_url if official.instance_variable_defined?(:@photo_url)
          unless official.address.nil?
            street_temp = official.address[0].line1
            city_temp = official.address[0].city
            state_temp = official.address[0].state
            zip_temp = official.address[0].zip
          end
        end
        party_temp = official.party
      end

      representative = Representative.find_or_initialize_by(name: official.name, ocdid: ocdid_temp)
      if representative.new_record?
        representative = Representative.create(name: official.name, ocdid: ocdid_temp,
                                               party: party_temp, photo_url: photo_url_temp,
                                               zip: zip_temp, address: street_temp,
                                               city: city_temp, state: state_temp)
        representative.title = title_temp
        representative.save!
      end
      reps.push(representative)
    end
    reps
  end
  # rubocop:enable Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength
end
