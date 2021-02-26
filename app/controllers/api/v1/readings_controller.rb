class Api::V1::ReadingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_reading, only: [:show, :update, :destroy]
  before_action :check_permission!, only: [:show, :update, :destroy]
  
  def index
    readings = @book.readings.where(user_id: current_user.id)
    json_response(readings)
  end

  def show
    json_response(@reading)
  end
  
  def create
    reading = @book.readings.new(reading_params)
    reading.user = current_user
    reading.save!
    json_response(reading, :created)
  end

  def update
    @reading.update!(reading_params)
    head :no_content
  end

  def destroy
    @reading.destroy!
    head :no_content
  end

  private
  
  def reading_params
    params.permit(:start_date, :finish_date, :status)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_reading
    @reading = @book.readings.find_by!(id: params[:id]) if @book
  end

  def check_permission!
    return_forbidden_resource unless @reading.user.id == current_user.id
  end
end