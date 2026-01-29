class AddSeaCreatureFieldsToCritters < ActiveRecord::Migration[8.0]
  def change
    add_column :critters, :movement_speed, :string
  end
end
