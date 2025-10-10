class AddCatchesToUnlockToCritters < ActiveRecord::Migration[8.0]
  def change
    add_column :critters, :catches_to_unlock, :integer
  end
end
