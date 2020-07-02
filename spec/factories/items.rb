FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character }
    # todo_id { create_one(:todo).id }
  end
end