class ReplaceMonthsJsonSpawnFromCrittersAvailabilities < ActiveRecord::Migration[8.0]
  def change
    remove_column :critter_availabilities, :months_json, :text
    add_column :critter_availabilities, :month, :integer
  end
end
