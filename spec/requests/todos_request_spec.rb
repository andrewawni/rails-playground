# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/todos', type: :request do
  let!(:user) { create(:user) }
  let!(:user_todos) { create_list(:todo, 10, user: user) }
  let(:todo_id) { user.todos.first.id }
  let(:auth_headers) do
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    { 'Authorization': "Bearer #{token}" }
  end

  describe 'Get /todos' do
    before { get '/todos', headers: auth_headers }

    it 'returns status code #{ok}' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}", headers: auth_headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty

        expect(json['_id']['$oid']).to eq(todo_id.to_s)
      end

      it 'returns status code #{ok}' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code #{not_found}' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/not found/)
      end
    end
  end

  describe 'POST /todos' do
    # valid payload
    let(:valid_attributes) {
       {
         todo: {
           title: 'Learn Elm' 
          }
        }
      } 

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes, headers: auth_headers }

      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code #{:created}' do
        expect(response).to have_http_status(:created)
      end
    end

    # context 'when the request is invalid' do
    #   before { post '/todos', params: { todo: {} }, headers: auth_headers }

    #   it 'returns status code #{:unprocessable_entity}' do
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end

    #   it 'returns a validation failure message' do
    #     expect(response.body)
    #       .to match(/Validation of Todo failed/)
    #   end
    # end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /todos/:id' do
    let(:valid_attributes) do
      {
        todo: {
          title: 'Shopping'
        }
      }
    end

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: auth_headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code #{:no_content}' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}", headers: auth_headers }

    it 'returns status code #{:no_content}' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
