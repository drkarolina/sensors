# frozen_string_literal: true

FactoryBot.define do
  factory :sensor do
    name { Faker::Device.model_name }
    location { Faker::Address.city }
    device { Faker::Device.manufacturer }
    location_max_capacity { Faker::Number.between(from: 1, to: 100) }
    external_id { SecureRandom.uuid }
  end
end
