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

    describe '.find_google_user' do
      it 'finds a user by UID for Google provider' do
        google_user = described_class.create(provider: :google_oauth2, uid: '123')
        found_user = described_class.find_google_user('123')
        expect(found_user).to eq(google_user)
      end
    end

    describe '.find_github_user' do
      it 'finds a user by UID for GitHub provider' do
        github_user = described_class.create(provider: :github, uid: '456')
        found_user = described_class.find_github_user('456')
        expect(found_user).to eq(github_user)
      end
    end
  end
end
