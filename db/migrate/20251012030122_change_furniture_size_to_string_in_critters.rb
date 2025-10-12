class ChangeFurnitureSizeToStringInCritters < ActiveRecord::Migration[8.0]
  def change
    change_column :critters, :furniture_size, :string
  end
end
