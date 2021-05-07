# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:pages).only_integer }
  it { should validate_numericality_of(:relevance) }
end
