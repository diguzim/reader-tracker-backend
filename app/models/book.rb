class Book < ApplicationRecord
  validates_presence_of :name, :author
  validates :pages, numericality: { only_integer: true }
  validates :relevance, numericality: true
end
