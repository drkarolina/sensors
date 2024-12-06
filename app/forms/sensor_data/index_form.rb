# frozen_string_literal: true

module SensorData
  class IndexForm
    include ActiveModel::Model

    attr_accessor :external_id, :start_date, :end_date

    validates :external_id, presence: true
    validate :dates_are_valid

    def initialize(params)
      @external_id = params[:external_id]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end

    private

    def dates_are_valid
      validate_date_format(:start_date, start_date)
      validate_date_format(:end_date, end_date)
    end

    def validate_date_format(attribute, value)
      return if value.blank?

      Date.parse(value.to_s)
    rescue ArgumentError
      errors.add(attribute, 'must be a valid date')
    end
  end
end
