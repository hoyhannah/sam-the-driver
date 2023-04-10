# frozen_string_literal: true

FactoryBot.define do
  factory :product_entity, class: 'Product' do
    id { rand(1..2) }
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 1..100.0) }
  end
end
