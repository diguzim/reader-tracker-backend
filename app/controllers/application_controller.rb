class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ActionController::MimeResponds

  respond_to :json
end
