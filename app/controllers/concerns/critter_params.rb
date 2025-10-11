module CritterParams
  extend ActiveSupport::Concern

  private

  def permitted_critter_params
    [
      :name,
      :entry_id,
      :sell_price,
      :furniture_size,
      :furniture_has_surface,
      :description,
      :catch_phrase,
      :catches_to_unlock,
      availabilities_attributes: [ :id, :month, :all_day, :start_minute, :end_minute, :hemisphere, :_destroy ]
    ]
  end
end
