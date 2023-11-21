# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

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
          photo_url_temp = official.photoUrl
          unless official.address.nil?
            city_temp = official.address[0].city
            state_temp = official.address[0].state
            zip_temp = official.address[0].zip
          end
        end
        party_temp = official.party
      end

      rep = Representative.find_or_initialize_by(name: official.name, ocdid: ocdid_temp)
      next unless rep.new_record?

      rep.title = title_temp
      rep.save!
      reps.push(rep)
    end
    reps
  end
end
