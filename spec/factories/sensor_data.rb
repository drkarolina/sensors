# frozen_string_literal: true

FactoryBot.define do
  factory :sensor_datum do
    line1_total_in { Faker::Number.between(from: 1, to: 1000) }
    line1_total_out { Faker::Number.between(from: 1, to: 1000) }
    line1_period_in { Faker::Number.between(from: 1, to: 100) }
    line1_period_out { Faker::Number.between(from: 1, to: 100) }
    location_occupancy_pct { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    reported_at { Faker::Time.backward(days: 7) }
    association :sensor
  end
end
