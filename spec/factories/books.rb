# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    name { Faker::Lorem.word }
    genre { Faker::Cannabis.strain }
    pages { Faker::Number.number(digits: 3) }
    relevance { Faker::Number.between(from: 1, to: 10) }
  end
end
