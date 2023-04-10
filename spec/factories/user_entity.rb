# frozen_string_literal: true

FactoryBot.define do
  factory :user_entity, class: User do
    id { 1 }
    name { 'some_name' }
    email { 'some_email' }
    password { 'some_password' }
  end
end
