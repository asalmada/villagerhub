class AddFishFieldsToCritters < ActiveRecord::Migration[8.0]
  def change
    add_column :critters, :shadow_size, :string
    add_column :critters, :catch_difficulty, :string
    add_column :critters, :visual_width, :string
  end
end
