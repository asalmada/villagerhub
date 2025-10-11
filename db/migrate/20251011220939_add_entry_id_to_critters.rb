class AddEntryIdToCritters < ActiveRecord::Migration[8.0]
  def change
    add_column :critters, :entry_id, :string
    add_index :critters, :entry_id, unique: true
  end
end
