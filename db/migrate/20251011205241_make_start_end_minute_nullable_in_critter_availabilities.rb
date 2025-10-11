class MakeStartEndMinuteNullableInCritterAvailabilities < ActiveRecord::Migration[8.0]
  def change
    change_column_null :critter_availabilities, :start_minute, true
    change_column_null :critter_availabilities, :end_minute, true
  end
end
