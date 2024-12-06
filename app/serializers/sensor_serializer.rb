# frozen_string_literal: true

class SensorSerializer < ActiveModel::Serializer
  attributes :id, :external_id, :name, :location, :device, :location_max_capacity

  has_many :sensor_data
end
