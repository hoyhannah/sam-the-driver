# frozen_string_literal: true

FactoryBot.define do
  factory :cart_entity, class: Cart do
    user_id { create(:user).id }
    active { true }
  end
end
