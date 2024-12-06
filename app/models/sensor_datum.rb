# frozen_string_literal: true

# == Schema Information
#
# Table name: sensor_data
#
#  id                     :bigint           not null, primary key
#  line1_total_in         :integer          not null
#  line1_total_out        :integer          not null
#  line1_period_in        :integer          not null
#  line1_period_out       :integer          not null
#  location_occupancy_pct :decimal(, )      not null
#  reported_at            :datetime         not null
#  sensor_id              :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class SensorDatum < ApplicationRecord
  belongs_to :sensor

  validates :line1_total_in, :line1_total_out, :line1_period_in, :line1_period_out,
            :location_occupancy_pct, :reported_at, presence: true
end
