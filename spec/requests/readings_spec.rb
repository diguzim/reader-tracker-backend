# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Readings API', type: :request do
  let(:user) { create(:user) }
  let(:wrong_user) { create(:user) }
  let!(:book) { create(:book, user_id: user.id) }
  let!(:readings) { create_list(:reading, 20, book_id: book.id, user_id: user.id) }
  let!(:book_id) { book.id }
  let(:reading_id) { readings.first.id }
  let(:user) { create(:user) }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
  let(:wrong_auth_headers) { Devise::JWT::TestHelpers.auth_headers({}, wrong_user) }

  describe 'GET /books/:book_id/readings' do
    before { get "/api/v1/books/#{book_id}/readings", headers: auth_headers }

    context 'when book exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all of it\'s readings' do
        expect(json.size).to eq(20)
      end
    end

    context 'when book doesn\'t exists' do
      let(:book_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Book/)
      end
    end
  end

  describe 'GET /books/:book_id/readings/:reading_id' do
    context 'when proper user is requesting' do
      before { get "/api/v1/books/#{book_id}/readings/#{reading_id}", headers: auth_headers }

      context 'when reading exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns the reading' do
          expect(json['id']).to eq(reading_id)
        end
      end

      context 'when reading does not exists' do
        let(:reading_id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Reading/)
        end
      end
    end
    context 'when unproper user is requesting' do
      before { get "/api/v1/books/#{book_id}/readings/#{reading_id}", headers: wrong_auth_headers }

      it 'should report permission errors' do
        report_forbidden_errors
      end
    end
  end

  describe 'POST /books/:book_id/readings' do
    let(:valid_attributes) { { start_date: Date.today, finish_date: Date.today, status: :in_progress } }

    context 'when request attributes are valid' do
      before { post "/api/v1/books/#{book_id}/readings", params: valid_attributes, headers: auth_headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are not valid' do
      before { post "/api/v1/books/#{book_id}/readings", params: {}, headers: auth_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: .* can't be blank/)
      end
    end
  end

  describe 'PUT /books/:book_id/readings/:reading_id' do
    let(:valid_attributes) { { status: :finished } }

    context 'when proper user is requesting' do
      before { put "/api/v1/books/#{book_id}/readings/#{reading_id}", params: valid_attributes, headers: auth_headers }

      context 'when reading exists' do
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        it 'updates the reading' do
          updated_reading = Reading.find(reading_id)
          expect(updated_reading.status).to eq('finished') # Not sure how to implement it better
        end
      end

      context 'when reading doesn\'t exists' do
        let(:reading_id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Reading/)
        end
      end
    end

    context 'when unproper user is requesting' do
      before do
        put "/api/v1/books/#{book_id}/readings/#{reading_id}", params: valid_attributes, headers: wrong_auth_headers
      end

      it 'should report permission errors' do
        report_forbidden_errors
      end
    end
  end

  describe 'PUT /books/:book_id/readings/:reading_id' do
    context 'when proper user is requesting' do
      before { delete "/api/v1/books/#{book_id}/readings/#{reading_id}", headers: auth_headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when unproper user is requesting' do
      before { delete "/api/v1/books/#{book_id}/readings/#{reading_id}", headers: wrong_auth_headers }

      it 'should report permission errors' do
        report_forbidden_errors
      end
    end
  end
end
