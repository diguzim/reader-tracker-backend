# frozen_string_literal: true

class Author < ApplicationRecord
  validates_presence_of :name

  belongs_to :user
end
