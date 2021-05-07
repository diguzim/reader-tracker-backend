# frozen_string_literal: true

module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :authenticate_user!, except: %i[index show]
      before_action :set_author, only: %i[show update destroy]
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

      private

      def author_params
        params.permit(:name)
      end

      def set_author
        @author = Author.find(params[:id])
      end

      def check_permission!
        return_forbidden_resource unless @author.user.id == current_user.id
      end
    end
  end
end
