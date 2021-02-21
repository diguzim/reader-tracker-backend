class Reading < ApplicationRecord
  belongs_to :book

  enum status: [ :in_progress, :finished, :suspended ]

  validates_presence_of :start_date, :status
end
