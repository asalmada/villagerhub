class AddTypeToCritters < ActiveRecord::Migration[8.0]
  def change
    add_column :critters, :type, :string
  end
end
