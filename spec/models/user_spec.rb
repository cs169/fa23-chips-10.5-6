# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'methods' do
    let(:user) { described_class.create(provider: :google_oauth2, uid: '123') }

    describe '#name' do
      it 'returns the full name' do
        user.update(first_name: 'John', last_name: 'Doe')
        expect(user.name).to eq('John Doe')
      end
    end

    describe '#auth_provider' do
      it 'returns the authentication provider name' do
        expect(user.auth_provider).to eq('Google')
      end
    end

    describe 'find_user_by_provider_and_uid' do
      shared_examples 'finds a user by UID for a provider' do |provider|
        provider_map = {
          google: { provider: :google_oauth2 },
          github: { provider: :github }
        }
        it "finds a user by UID for #{provider} provider" do
          user = described_class.create(provider_map[provider].merge(uid: '123')) ||
                 (raise "Unsupported authentication provider: #{provider}")
          found_user = described_class.send("find_#{provider}_user", '123')
          expect(found_user).to eq(user)
        end
      end

      it_behaves_like 'finds a user by UID for a provider', :google
      it_behaves_like 'finds a user by UID for a provider', :github
    end
  end
end
