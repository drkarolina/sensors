# frozen_string_literal: true

class CreateSensorData < ActiveRecord::Migration[7.1]
  def change
    create_table :sensor_data do |t|
      t.integer :line1_total_in, null: false
      t.integer :line1_total_out, null: false
      t.integer :line1_period_in, null: false
      t.integer :line1_period_out, null: false
      t.decimal :location_occupancy_pct, null: false
      t.datetime :reported_at, null: false

      t.references :sensor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
