# frozen_string_literal: true

class CreateSensors < ActiveRecord::Migration[7.1]
  def change
    create_table :sensors do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :device, null: false
      t.integer :location_max_capacity, null: false
      t.string :external_id, null: false

      t.timestamps
    end
    add_index :sensors, :external_id
  end
end
