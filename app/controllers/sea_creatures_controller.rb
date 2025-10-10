class SeaCreaturesController < ApplicationController
  def new
    @sea_creature = SeaCreature.new
  end

  def create
    @sea_creature = SeaCreature.new(sea_creature_params)
    if @sea_creature.save
      redirect_to @sea_creature
    else
      render :new
    end
  end

  private

  def sea_creature_params
    params.require(:sea_creature).permit(
      :name,
      :sell_price,
      :furniture_size,
      :furniture_has_surface,
      :description,
      :catch_phrase,
      :catches_to_unlock,
      :movement_speed
    )
  end
end
