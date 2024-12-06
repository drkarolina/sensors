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
require 'rails_helper'

RSpec.describe Sensor, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:sensor_data).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:device) }
    it { is_expected.to validate_presence_of(:location_max_capacity) }
    it { is_expected.to validate_presence_of(:external_id) }
  end

  describe 'factory' do
    it 'is valid with valid attributes' do
      expect(build(:sensor)).to be_valid
    end
  end
end
