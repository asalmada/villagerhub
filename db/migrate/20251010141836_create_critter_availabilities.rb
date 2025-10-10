class CreateCritterAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :critter_availabilities do |t|
      t.references :critter, null: false, foreign_key: true
      t.string :hemisphere
      t.text :months_json, null: false
      t.integer :start_minute
      t.integer :end_minute
      t.boolean :all_day

      t.timestamps
    end
  end
end
