# frozen_string_literal: true

module SensorDataServices
  class Index
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
      @form = SensorData::IndexForm.new(params)
    end

    def call
      return { status: :unprocessable_entity, errors: form.errors.full_messages } unless form.valid?
      return { status: :not_found } unless sensor

      { data: filetered_data, status: :ok }
    end

    private

    attr_reader :params, :form

    def sensor
      @sensor = Sensor.find_by(external_id: params[:external_id])
    end

    def filetered_data
      sensor.sensor_data
            &.where(reported_at: params[:start_date]..params[:end_date])
            &.order(reported_at: :desc)
    end
  end
end
