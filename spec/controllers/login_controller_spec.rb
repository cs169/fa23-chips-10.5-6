# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe '#login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe '#logout' do
    it 'clears current_user_id from the session and redirects to root_path' do
      session[:current_user_id] = 1
      get :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('You have successfully logged out.')
    end
  end

  describe '#already_logged_in' do
    it 'redirects to user_profile_path with a notice if user is already logged in' do
      session[:current_user_id] = 1
      allow(controller).to receive(:redirect_to)
      controller.send(:already_logged_in)
      notice = { notice: 'You are already logged in. Logout to switch accounts.' }
      expect(controller).to have_received(:redirect_to).with(user_profile_path, notice)
    end

    it 'does not redirect if user is not logged in' do
      allow(controller).to receive(:redirect_to)
      controller.send(:already_logged_in)
      expect(controller).not_to have_received(:redirect_to)
    end
  end

  describe '#create_github_user' do
    shared_examples 'creates a GitHub user' do |user_info, expected_params|
      it 'creates a GitHub user with valid user_info' do
        allow(User).to receive(:create)
        controller.send(:create_github_user, user_info)
        expect(User).to have_received(:create).with(expected_params)
      end
    end

    it_behaves_like 'creates a GitHub user',
                    { 'uid' => '123456', 'info' => { 'name' => 'John Doe', 'email' => 'john.doe@example.com' } },
                    { uid: '123456', provider: User.providers[:github], first_name: 'John', last_name: 'Doe',
email: 'john.doe@example.com' }

    it_behaves_like 'creates a GitHub user',
                    { 'uid' => '789012', 'info' => { 'name' => nil, 'email' => 'anon.user@example.com' } },
                    { uid: '789012', provider: User.providers[:github], first_name: 'Anon', last_name: 'User',
email: 'anon.user@example.com' }
  end
end
