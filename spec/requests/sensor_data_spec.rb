# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SensorData, type: :request do
  describe 'POST /sensor_data' do
    let(:valid_params) do
      {
        mongoId: Faker::Internet.uuid,
        _id: Faker::Internet.uuid,
        name: Faker::Device.model_name,
        description: Faker::Lorem.sentence,
        activationType: 'OTAA',
        devEui: Faker::Alphanumeric.alphanumeric(number: 16).upcase,
        appKey: Faker::Alphanumeric.alphanumeric(number: 32).upcase,
        contextMap: {
          name: Faker::Device.model_name,
          location: Faker::Address.community,
          device: Faker::Device.platform,
          location_max_capacity: Faker::Number.between(from: 50, to: 100).to_s
        },
        deviceModelName: Faker::Device.platform,
        reportedAt: Faker::Time.backward(days: 365),
        synchronizedAt: Faker::Time.backward(days: 30),
        line1TotalIn: Faker::Number.between(from: 0, to: 1000),
        line1TotalOut: Faker::Number.between(from: 0, to: 1000),
        line1PeriodIn: Faker::Number.between(from: 0, to: 10),
        line1PeriodOut: Faker::Number.between(from: 0, to: 10),
        total_sum: Faker::Number.number(digits: 5),
        createdAt: Faker::Time.backward(days: 100).iso8601,
        updatedAt: Faker::Time.backward(days: 10).iso8601
      }
    end

    context 'with valid params' do
      let(:sensor) { Sensor.find_by(external_id: valid_params[:_id]) }
      let(:location_max_capacity) { valid_params.dig(:contextMap, :location_max_capacity).to_f }
      let(:location_occupancy_pct) do
        ((valid_params[:line1TotalIn].to_i - valid_params[:line1TotalOut].to_i) / location_max_capacity * 100).round(2)
      end

      before { post '/sensor_data', params: valid_params }

      it 'renders correct response' do
        expect(response).to have_http_status(:created)
        validate_json_schema('sensor_data/create', response.body)
      end

      it 'creates sensor with correct attributes' do
        expect(sensor).not_to be_nil
        expect(sensor.external_id).to eq(valid_params[:_id])
        expect(sensor.name).to eq(valid_params.dig(:contextMap, :name))
        expect(sensor.location).to eq(valid_params.dig(:contextMap, :location))
        expect(sensor.device).to eq(valid_params.dig(:contextMap, :device))
        expect(sensor.location_max_capacity).to eq(valid_params.dig(:contextMap, :location_max_capacity).to_i)
      end

      it 'creates sensor data with correct attributes' do
        sensor_data = sensor.sensor_data.first

        expect(sensor_data).not_to be_nil
        expect(sensor_data.reported_at).to eq(valid_params[:reportedAt])
        expect(sensor_data.line1_total_in).to eq(valid_params[:line1TotalIn])
        expect(sensor_data.line1_total_out).to eq(valid_params[:line1TotalOut])
        expect(sensor_data.line1_period_in).to eq(valid_params[:line1PeriodIn])
        expect(sensor_data.line1_period_out).to eq(valid_params[:line1PeriodOut])
        expect(sensor_data.location_occupancy_pct).to eq(location_occupancy_pct)
      end

      context 'when sensor exists' do
        before { create(:sensor, external_id: valid_params[:_id]) }

        it 'does not create new Sensor' do
          expect { post '/sensor_data', params: valid_params }.not_to change(Sensor, :count)
        end

        it 'creates new SensorDatum' do
          expect { post '/sensor_data', params: valid_params }.to change(SensorDatum, :count).by(1)
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { valid_params.except(:_id, :contextMap, :line1TotalIn, :line1TotalOut, :reportedAt) }
      let(:expected_errors) do
        [
          "Id can't be blank",
          "Context map can't be blank",
          "Line1 total in can't be blank",
          "Line1 total out can't be blank",
          "Reported at can't be blank",
          "Context map Name can't be blank",
          "Context map Location can't be blank",
          "Context map Device can't be blank",
          "Context map Location max capacity can't be blank"
        ]
      end

      before { post '/sensor_data', params: invalid_params }

      it 'renders correct response' do
        expect(response).to have_http_status(:unprocessable_entity)
        validate_json_schema('errors', response.body)
      end

      it 'renders correct messages' do
        actual_errors = response.parsed_body['errors'].map(&:strip)
        errors = expected_errors.map(&:strip)

        expect(actual_errors).to match_array(errors)
      end
    end
  end

  describe 'GET /sensor_data' do
    context 'with valid params' do
      let(:external_id) { Faker::Internet.uuid }
      let(:sensor) { create(:sensor, external_id: external_id) }

      before do
        create(:sensor_datum, sensor: sensor, reported_at: '2020-10-25T13:08:42.512Z')
        create(:sensor_datum, sensor: sensor, reported_at: '2020-11-25T13:08:42.512Z')
        create(:sensor_datum, sensor: sensor, reported_at: '2020-12-25T13:08:42.512Z')
      end

      context 'when sensor data was found' do
        let(:valid_params) do
          {
            external_id: external_id,
            start_date: '2020-10-25T13:08:42.512Z',
            end_date: '2020-11-25T13:08:42.512Z'
          }
        end

        before { get '/sensor_data', params: valid_params }

        it 'renders correct respons' do
          expect(response).to have_http_status(:ok)
          validate_json_schema('sensor_data/index', response.body)
        end

        it 'returns sensor data in descending order of reported_at' do
          reported_ats = response.parsed_body.map { |item| item['reported_at'] }
          expect(reported_ats).to eq(reported_ats.sort.reverse)
        end

        it 'returns filtered data' do
          expect(response.parsed_body.count).to eq(2)
        end
      end

      context 'when no sensor found' do
        let(:valid_params_no_data) do
          {
            external_id: '6638e33770ea3168dfc79051',
            start_date: '2020-10-25T13:08:42.512Z',
            end_date: '2020-11-25T13:08:42.512Z'
          }
        end

        before { get '/sensor_data', params: valid_params_no_data }

        it 'returns a not found response' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          start_date: 'a',
          end_date: 'a'
        }
      end
      let(:expected_errors) do
        [
          "External can't be blank",
          'Start date must be a valid date',
          'End date must be a valid date'
        ]
      end

      before { get '/sensor_data', params: invalid_params }

      it 'renders correct response' do
        expect(response).to have_http_status(:unprocessable_entity)
        validate_json_schema('errors', response.body)
      end

      it 'renders correct messages' do
        actual_errors = response.parsed_body['errors'].map(&:strip)
        errors = expected_errors.map(&:strip)

        expect(actual_errors).to match_array(errors)
      end
    end
  end
end
