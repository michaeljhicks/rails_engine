FactoryBot.define do
  factory :item do
    name { Faker::Food.dish }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Commerce.price }
    merchant
  end
end
