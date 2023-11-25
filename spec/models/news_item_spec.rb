# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe 'associations' do
    it 'has many ratings' do
      expect(described_class.reflect_on_association(:ratings).macro).to eq(:has_many)
    end

    it 'belongs to representative' do
      expect(described_class.reflect_on_association(:representative).macro).to eq(:belongs_to)
    end
  end

  describe 'methods' do
    describe '.find_for' do
      it 'returns the news item for the given representative_id' do
        rep = Representative.create(name: 'John Doe', ocdid: 'some-ocdid-1', title: 'Mayor')
        news_item = described_class.create(title: 'Test Title', link: 'https://example.com', representative: rep)
        expect(news_item.representative).to eq(rep)
        expect(rep.news_items).to include(news_item)
      end

      it 'returns nil if no news item is found for the given representative_id' do
        found_news_item = described_class.find_for(999)
        expect(found_news_item).to be_nil
      end
    end
  end
end
