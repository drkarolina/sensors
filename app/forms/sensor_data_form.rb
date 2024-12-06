# frozen_string_literal: true

class SensorDataForm
  include ActiveModel::Model

  attr_accessor :_id, :context_map, :line1_total_in, :line1_total_out,
                :line1_period_in, :line1_period_out, :reported_at

  validates :_id, :context_map, :line1_total_in, :line1_total_out,
            :line1_period_in, :line1_period_out, :reported_at, presence: true
  validate :validate_context_map

  def validate_context_map
    sensor_form = SensorForm.new(context_map)

    return if sensor_form.valid?

    sensor_form.errors.full_messages.each do |attribute, message|
      errors.add(:context_map, "#{attribute} #{message}")
    end
  end
end
