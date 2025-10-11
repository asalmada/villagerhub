class MakeEntryIdNotNullInCritters < ActiveRecord::Migration[8.0]
  def change
    change_column_null :critters, :entry_id, false
  end
end
