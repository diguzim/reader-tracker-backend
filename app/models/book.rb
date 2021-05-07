# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :readings, dependent: :destroy
  has_many :authorships
  has_many :authors, through: :authorships
  belongs_to :user

  validates_presence_of :name
  validates :pages, numericality: { only_integer: true }
  validates :relevance, numericality: true
end
