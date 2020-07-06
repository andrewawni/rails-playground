# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /auth/signin' do
  let!(:user_signup) do
    post '/auth/signup', params: {
      user: {
        email: 'andrew@gmail.com',
        password: '123',
        password_confirmation: '123'
      }
    }
  end

  let(:valid_auth_params) do
    {
      email: 'andrew@gmail.com',
      password: '123'
    }
  end

  let(:invalid_auth_params) do
    {
      email: 'test@gmail.com',
      password: '123'
    }
  end

  def user_signin(auth_params)
    post '/auth/signin', params: { auth: auth_params }
  end

  context 'with valid parameters' do
    it 'returns a token' do
      user_signin(valid_auth_params)
      json
      expect(response).to have_http_status(:created)
    end
  end

  context 'with invalid parameters' do
    context 'with invalid email' do
      it 'returns 404 not found' do
        user_signin(invalid_auth_params)
        json
        expect(response).to have_http_status(:not_found)
      end
    end
    context 'with invalid passowrd' do
      it 'returns 404 not found' do
        invalid_auth_params = valid_auth_params
        invalid_auth_params[:password] = 'invalidpwd'
        user_signin(invalid_auth_params)
        expect(response).to have_http_status(:not_found)

      end
    end
  end
end
