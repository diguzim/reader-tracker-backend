require 'rails_helper'

RSpec.describe 'Readings API', type: :request do
  let!(:book) { create(:book) }
  let!(:readings) { create_list(:reading, 20, book_id: book.id) }
  let!(:book_id) { book.id }
  let(:reading_id) { readings.first.id }
  
  describe('GET /books/:book_id/readings') do
    before { get "/api/v1/books/#{book_id}/readings" }

    context 'when book exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all of it\'s readings' do
        expect(json.size).to eq(20)
      end
    end
  end
end