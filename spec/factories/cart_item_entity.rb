# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item_entity, class: CartItem do
    item_id { nil }
    quantity { 1 }
    cart_id { create(:cart).id }
  end
end
