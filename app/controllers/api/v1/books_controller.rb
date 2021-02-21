class Api::V1::BooksController < ApplicationController
  def index
    books = Book.all
    render json: { results: books }.to_json, status: :ok
  end

  def show
    book = Book.find(params[:id])
    render json: { results: book }.to_json, status: :ok
  end

  def create
    book = Book.new(book_params)
    book.save
    unless book.valid?
      render json: { errors: book.errors.full_messages }.to_json, status: :bad_request
    end
  end

  # def update
  #   book = Book.find_by_id(params[:id])
  #   if book.nil?
  #     render json: { errors: ["Book not found"] }.to_json, status: :not_found
  #   end
  #   puts book.name

  #   book.update(book_params)
  #   unless book.valid?
  #     render json: { errors: book.errors.full_messages }.to_json, status: :bad_request
  #   end
  # end

  private
  def book_params
    params.permit(:name, :author, :genre, :pages, :relevance)
  end
end