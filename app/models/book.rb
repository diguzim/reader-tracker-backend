# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :readings, dependent: :destroy
  belongs_to :user

  validates_presence_of :name
  validates :pages, numericality: { only_integer: true }
  validates :relevance, numericality: true
end
