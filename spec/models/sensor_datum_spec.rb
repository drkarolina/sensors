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
require 'rails_helper'

RSpec.describe SensorDatum, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:sensor) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:line1_total_in) }
    it { is_expected.to validate_presence_of(:line1_total_out) }
    it { is_expected.to validate_presence_of(:line1_period_in) }
    it { is_expected.to validate_presence_of(:line1_period_out) }
    it { is_expected.to validate_presence_of(:location_occupancy_pct) }
    it { is_expected.to validate_presence_of(:reported_at) }
  end

  describe 'factory' do
    it 'is valid with valid attributes' do
      expect(build(:sensor_datum)).to be_valid
    end
  end
end
