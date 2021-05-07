# frozen_string_literal: true

class Author < ApplicationRecord
  validates_presence_of :name
  has_many :authorships
  has_many :books, through: :authorships

  belongs_to :user
end
