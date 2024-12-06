# frozen_string_literal: true

class SensorDataController < ApplicationController
  def create
    run SensorDataServices::Create, sensor_params, serializer: SensorSerializer
  end

  def index
    run SensorDataServices::Index, params
  end

  private

  def sensor_params
    params
      .deep_transform_keys(&:underscore)
      .permit(:_id, :line1_total_in, :line1_total_out, :line1_period_in, :line1_period_out, :reported_at,
              context_map: %i[name location device location_max_capacity])
  end
end
