class CrittersController < ApplicationController
  def index
    @critters = Critter.all
  end

  def show
    @critter = Critter.find(params[:id])
  end

  def new
    @critter = Critter.new
  end

  def create
    @critter = Critter.new(critter_params)
    if @critter.save
      redirect_to critters_path
    else
      Rails.logger.debug(@critter.errors.full_messages)
      render :new, status: :unprocessable_entity
    end
  end

  private
    def critter_params
      params.require(:critter).permit(:name, :type, :sell_price, :furniture_size, :furniture_has_surface, :description, :catch_phrase, :catches_to_unlock, :spawn_location, :shadow_size, :visual_width, :catch_difficulty)
    end
end
