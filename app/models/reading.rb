# frozen_string_literal: true

class Reading < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum status: %i[in_progress finished suspended]

  validates_presence_of :start_date, :status
end
