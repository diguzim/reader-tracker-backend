FactoryBot.define do
  factory :reading do
    book_id { nil }
    start_date { Date.today }
    status { Faker::Number.between(from: 0, to: 2) }
  end
end