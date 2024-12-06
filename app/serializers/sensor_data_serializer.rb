# frozen_string_literal: true

class SensorDataSerializer < ActiveModel::Serializer
  attributes :id, :line1_total_in, :line1_total_out, :line1_period_in, :line1_period_out,
             :location_occupancy_pct, :reported_at
end
