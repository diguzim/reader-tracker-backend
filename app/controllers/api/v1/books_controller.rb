# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_book, only: %i[show update destroy authors add_authorship destroy_authorship]
      before_action :set_author, only: %i[add_authorship destroy_authorship]
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
        authorize @book
        @book.update(book_params)
        head :no_content
      end

      def destroy
        @book.destroy
        head :no_content
      end

      def authors
        authors = @book.authors
        json_response(authors)
      end

      def add_authorship
        authorship.assign_attributes(authorship_params)
        authorship.save
        head :no_content
      end

      def destroy_authorship
        @author.books.delete(@book)
        head :no_content
      end

      private

      def book_params
        params.permit(:name, :author, :genre, :pages, :relevance)
      end

      def authorship_params
        params.permit(:main_contributor)
      end

      def set_author
        @author = Author.find(params[:author_id])
      end

      def set_book
        @book = Book.find(params[:id])
      end

      def check_permission!
        return_forbidden_resource unless @book.user.id == current_user.id
      end

      def authorship
        return @authorship if defined?(@authorship)

        existing_entry = Authorship.find_by(book_id: @book.id, author_id: @author.id)
        @authorship = existing_entry if existing_entry
        return @authorship if existing_entry

        @authorship = @author.authorships.build do |new_authorship|
          new_authorship.book = @book
        end
      end
    end
  end
end
