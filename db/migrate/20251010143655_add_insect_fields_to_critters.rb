class AddInsectFieldsToCritters < ActiveRecord::Migration[8.0]
  def change
    add_column :critters, :spawn_location, :string
    add_column :critters, :spawn_weather, :string
  end
end
