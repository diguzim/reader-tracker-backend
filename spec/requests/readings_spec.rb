require 'rails_helper'

RSpec.describe 'Readings API', type: :request do
  let!(:book) { create(:book) }
  let!(:readings) { create_list(:reading, 20, book_id: book.id) }
  let!(:book_id) { book.id }
  let(:reading_id) { readings.first.id }
  
  describe 'GET /books/:book_id/readings' do
    before { get "/api/v1/books/#{book_id}/readings" }

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
    before { get "/api/v1/books/#{book_id}/readings/#{reading_id}" }

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

  describe 'POST /books/:book_id/readings' do
    let(:valid_attributes) { { start_date: Date.today, finish_date: Date.today, status: :in_progress } }

    context 'when request attributes are valid' do
      before { post "/api/v1/books/#{book_id}/readings", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are valid' do
      before { post "/api/v1/books/#{book_id}/readings", params: {} }

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

    before { put "/api/v1/books/#{book_id}/readings/#{reading_id}", params: valid_attributes }

    context 'when reading exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the reading' do
        updated_reading = Reading.find(reading_id)
        expect(updated_reading.status).to eq("finished") # Not sure how to implement it better
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

  describe 'PUT /books/:book_id/readings/:reading_id' do
    before { delete "/api/v1/books/#{book_id}/readings/#{reading_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end