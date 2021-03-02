# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # initialize test data
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  # test suite for GET /todos
  describe 'GET /todos' do
    # make http request before each example
    before { get '/todos' }

    it 'returns todos' do
      # Note `json` is the custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  # test suite for GET /todos/:id
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'when a record exists' do
      it 'returns the todo' do
        expect(json).not_to be_nil
        expect(json['id']).to eq(todo_id)
      end

      it 'returns http status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/couldn't find Todo/i)
      end
    end
  end

  # test suite for POST /todos
  describe 'POST /todos' do
    let(:valid_attributes) { { title: 'Learn Rails', created_by: '1' } }

    context 'when request is valid' do
      before { post '/todos', params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq('Learn Rails')
      end

      it 'have http status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when request is invalid' do
      before { post '/todos', params: { title: 'Can be anything' } }

      it 'returns http status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # test suite for PUT /todos/:id
  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns http status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  # test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}" }

    it 'returns http status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
