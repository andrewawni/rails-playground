# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /auth/signup' do
  let(:valid_params) do
    {
      email: 'adel@shakal.com',
      password: '123',
      password_confirmation: '123'
    }
  end

  let(:invalid_params) do
    {
      email: 'adel@shakal.com',
      password: '1235',
      password_confirmation: '123'
    }
  end

  def user_signup(user_params)
    post '/auth/signup', params: { user: user_params }
  end

  context 'with valid parameters' do
    it 'creates a new user' do
      expect { user_signup(valid_params) }.to change { User.count }.by(1)
      expect(response).to have_http_status(:created)
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new user' do
      expect { user_signup(invalid_params) }.to change { User.count }.by(0)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'with an already registered user' do
    it 'does not create a new user' do
      user_signup(valid_params)
      user_signup(valid_params)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
