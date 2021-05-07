# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    user_id { nil }
    name { Faker::Name.unique.name }
  end
end
