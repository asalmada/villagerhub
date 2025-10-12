class FishController < ApplicationController
  include CritterParams
  before_action :set_fish, only: %i[ show edit update destroy ]
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @fish = Fish.all
  end

  def show
  end

  def new
    @fish = Fish.new
    @fish.availabilities.build
  end

  def create
    @fish = Fish.new(fish_params)
    if @fish.save
      redirect_to @fish
    else
      render :new
    end
  end

  def edit
    @fish.availabilities.build if @fish.availabilities.empty?
  end

  def update
    if @fish.update(fish_params)
      redirect_to @fish
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fish.destroy
    redirect_to fish_index_path
  end

  private
  def set_fish
    @fish = Fish.find(params[:id])
  end
  def fish_params
    params.require(:fish).permit(
      *permitted_critter_params,
      :spawn_location,
      :shadow_size,
      :visual_width,
      :catch_difficulty
    )
  end
end
