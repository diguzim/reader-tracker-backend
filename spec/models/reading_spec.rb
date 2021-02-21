require 'rails_helper'

RSpec.describe Reading, type: :model do
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:status) }
  it { should define_enum_for(:status).with([:in_progress, :finished, :suspended]) }
end
