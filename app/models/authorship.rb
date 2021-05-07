# frozen_string_literal: true

class Authorship < ApplicationRecord
  attribute :main_contributor, default: true

  belongs_to :author
  belongs_to :book
end
