# frozen_string_literal: true

class SensorForm
  include ActiveModel::Model

  attr_accessor :name, :location, :device, :location_max_capacity

  validates :name, :location, :device, :location_max_capacity, presence: true
end
