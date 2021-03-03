# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_book, only: %i[show update destroy]
      before_action :check_permission!, only: %i[update destroy]

      def index
        @books = Book.all
        json_response(@books)
      end

      def create
        @book = current_user.books.create!(book_params)
        json_response(@book, :created)
      end

      def show
        json_response(@book)
      end

      def update
        @book.update(book_params)
        head :no_content
      end

      def destroy
        @book.destroy
        head :no_content
      end

      private

      def book_params
        params.permit(:name, :author, :genre, :pages, :relevance)
      end

      def set_book
        @book = Book.find(params[:id])
      end

      def check_permission!
        return_forbidden_resource unless @book.user.id == current_user.id
      end
    end
  end
end
