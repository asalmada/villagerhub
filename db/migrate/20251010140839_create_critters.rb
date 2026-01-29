class CreateCritters < ActiveRecord::Migration[8.0]
  def change
    create_table :critters do |t|
      t.string :name
      t.integer :sell_price
      t.integer :spawn_probability
      t.integer :furniture_size
      t.boolean :furniture_has_surface
      t.text :description
      t.string :catch_phrase

      t.timestamps
    end
  end
end
