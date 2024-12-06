# frozen_string_literal: true

module SensorDataServices
  class Create
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
      @form = SensorDataForm.new(params)
    end

    def call
      return { status: :unprocessable_entity, errors: form.errors.full_messages } unless form.valid?
      return { status: :unprocessable_entity, errors: sensor.errors.full_messages } unless sensor.valid?
      return { status: :unprocessable_entity, errors: sensor_data.errors.full_messages } unless sensor_data.valid?

      { status: :created, data: sensor }
    end

    private

    attr_reader :params, :form

    def sensor
      @sensor ||= Sensor.find_or_initialize_by(external_id: params[:_id]).tap do |sensor|
        return sensor unless sensor.new_record?

        sensor.assign_attributes(sensor_params)
        sensor.save
      end
    end

    def sensor_data
      @sensor_data ||= sensor.sensor_data.create(sensor_datum_params)
    end

    def sensor_params
      {
        name: params.dig(:context_map, :name),
        location: params.dig(:context_map, :location),
        device: params.dig(:context_map, :device),
        location_max_capacity: params.dig(:context_map, :location_max_capacity).to_i
      }
    end

    def sensor_datum_params
      {
        line1_total_in: params[:line1_total_in],
        line1_total_out: params[:line1_total_out],
        line1_period_in: params[:line1_period_in],
        line1_period_out: params[:line1_period_out],
        location_occupancy_pct: occupancy_pct,
        reported_at: params[:reported_at]
      }
    end

    def occupancy_pct
      max_capacity = sensor.location_max_capacity
      return 0 if max_capacity.zero?

      ((params[:line1_total_in].to_i - params[:line1_total_out].to_i) / max_capacity.to_f * 100).round(2)
    end
  end
end
