class EnforceNotNullConstraints < ActiveRecord::Migration[8.0]
  def change
    change_column_null :critters, :name, false
    change_column_null :critters, :sell_price, false
    change_column_null :critters, :furniture_size, false
    change_column_null :critters, :furniture_has_surface, false
    change_column_null :critters, :description, false
    change_column_null :critters, :catch_phrase, false
    change_column_null :critters, :catches_to_unlock, false
    change_column_null :critter_availabilities, :hemisphere, false
    change_column_null :critter_availabilities, :start_minute, false
    change_column_null :critter_availabilities, :end_minute, false
    change_column_null :critter_availabilities, :all_day, false
    change_column_null :critter_availabilities, :month, false
  end
end
