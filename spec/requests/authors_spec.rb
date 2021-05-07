# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Authors API', type: :request do
  let(:user) { create(:user) }
  let(:wrong_user) { create(:user) }
  let(:author) { create(:author) }
  let!(:authors) { create_list(:author, 10, user_id: user.id) }
  let(:author_id) { authors.first.id }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
  let(:wrong_auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, wrong_user) }

  describe 'GET /authors' do
    before { get '/api/v1/authors' }

    it 'return authors' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /authors/:id' do
    before { get "/api/v1/authors/#{author_id}" }

    context 'when the recors exists' do
      it 'returns the author' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(author_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:author_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Author/)
      end
    end
  end

  describe 'POST /authors' do
    let(:valid_attributes) do
      { name: 'Some Name' }
    end

    context 'when the request is valid' do
      before { post '/api/v1/authors', params: valid_attributes, headers: auth_headers }

      it 'creates a author' do
        expect(json['name']).to eq('Some Name')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/authors', params: {}, headers: auth_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end

    context 'when the request is not authenticated' do
      before { post '/api/v1/authors', params: { name: 'Foobar' } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/You need to sign in or sign up before continuing./)
      end
    end
  end

  describe 'PUT authors/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when proper user is requesting' do
      context 'when the record exists' do
        before { put "/api/v1/authors/#{author_id}", params: valid_attributes, headers: auth_headers }

        it 'updates the record' do
          expect(response.body).to be_empty
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'when the request is not authenticated' do
        before { put "/api/v1/authors/#{author_id}", params: valid_attributes }

        it 'returns status code 401' do
          expect(response).to have_http_status(401)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/You need to sign in or sign up before continuing./)
        end
      end
    end

    context 'when unproper user is requesting' do
      before { put "/api/v1/authors/#{author_id}", params: valid_attributes, headers: wrong_auth_headers }

      it 'should report permission errors' do
        report_forbidden_errors
      end
    end
  end

  describe 'DELETE authors/:id' do
    context 'when proper user is requesting' do
      context 'when the record exists' do
        before { delete "/api/v1/authors/#{author_id}", headers: auth_headers }

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end

      context 'when the request is not authenticated' do
        before { delete "/api/v1/authors/#{author_id}" }

        it 'returns status code 401' do
          expect(response).to have_http_status(401)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/You need to sign in or sign up before continuing./)
        end
      end
    end

    context 'when unproper user is requesting' do
      before { delete "/api/v1/authors/#{author_id}", headers: wrong_auth_headers }

      it 'should report permission errors' do
        report_forbidden_errors
      end
    end
  end
end
