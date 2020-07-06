FactoryBot.define do
  factory :todo do
    title {Faker::Lorem.word}
    association :user
  end
end