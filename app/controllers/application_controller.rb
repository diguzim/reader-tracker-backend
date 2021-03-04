# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ActionController::MimeResponds
  include Pundit

  respond_to :json

  private

  def return_forbidden_resource
    render json: { error: "You don't have the permission to handle this resource" }, status: 403
  end
end
