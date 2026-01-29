class RemoveSpawnProbabilityFromCritters < ActiveRecord::Migration[8.0]
  def change
    remove_column :critters, :spawn_probability, :integer
  end
end
