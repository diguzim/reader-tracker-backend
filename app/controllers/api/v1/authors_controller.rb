# frozen_string_literal: true

module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_author, only: %i[show update destroy books add_authorship destroy_authorship]
      before_action :set_book, only: %i[add_authorship destroy_authorship]
      before_action :check_permission!, only: %i[update destroy]

      def index
        @authors = Author.all
        json_response(@authors)
      end

      def create
        @author = current_user.authors.create!(author_params)
        json_response(@author, :created)
      end

      def show
        json_response(@author)
      end

      def update
        authorize @author
        @author.update(author_params)
        head :no_content
      end

      def destroy
        authorize @author
        @author.destroy
        head :no_content
      end

      def books
        books = @author.books
        json_response(books)
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

      def author_params
        params.permit(:name)
      end

      def authorship_params
        params.permit(:main_contributor)
      end

      def set_author
        @author = Author.find(params[:id])
      end

      def set_book
        @book = Book.find(params[:book_id])
      end

      def check_permission!
        return_forbidden_resource unless @author.user.id == current_user.id
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
