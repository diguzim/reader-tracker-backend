# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reading, type: :model do
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:status) }
  it { should define_enum_for(:status).with(%i[in_progress finished suspended]) }
end
