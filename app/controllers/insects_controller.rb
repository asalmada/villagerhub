class InsectsController < ApplicationController
  def new
    @insect = Insect.new
  end

  def create
    @insect = Insect.new(insect_params)
    if @insect.save
      redirect_to @insect
    else
      render :new
    end
  end

  private

  def insect_params
    params.require(:insect).permit(
      :name,
      :sell_price,
      :furniture_size,
      :furniture_has_surface,
      :description,
      :catch_phrase,
      :catches_to_unlock,
      :spawn_location,
      :spawn_weather
    )
  end
end
