class Api::V1::ReadingsController < ApplicationController
  before_action :set_book
  before_action :set_reading, only: [:show, :update, :destroy]
  
  def index
    json_response(@book.readings)
  end

  def show
    json_response(@reading)
  end
  
  def create
  end

  def update
  end

  def destroy
  end

  private
  
  def book_params
    params.permit(:name, :author, :genre, :pages, :relevance)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_reading
    @reading = @book.readings.find_by!(id: params[:id]) if @book
  end
end