# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include AdminSecured
      before_action :set_user

      def destroy
        @user.destroy!
        head :no_content
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
