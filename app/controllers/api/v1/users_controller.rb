class Api::V1::UsersController < ApplicationController
  include Secured
  before_action :set_user

  def destroy
    @user.destroy!
    head :no_content
  end

  def set_user
    @user = User.find(params[:id])
  end
end
