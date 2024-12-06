# frozen_string_literal: true

# == Schema Information
#
# Table name: sensors
#
#  id                    :bigint           not null, primary key
#  name                  :string           not null
#  location              :string           not null
#  device                :string           not null
#  location_max_capacity :integer          not null
#  external_id           :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Sensor < ApplicationRecord
  has_many :sensor_data, dependent: :destroy

  validates :name, :location, :device, :location_max_capacity, :external_id, presence: true
end
