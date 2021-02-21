class Book < ApplicationRecord
  validates :name, presence: true
  validates :author, presence: true
  validates :pages, numericality: { only_integer: true }
  validates :relevance, numericality: true
end
