class Admin::FishController < ApplicationController
  include Admin::CritterParams
  before_action :set_fish, only: %i[ show edit update destroy ]

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
      redirect_to [ :admin, @fish ]
    else
      render :new
    end
  end

  def edit
    @fish.availabilities.build if @fish.availabilities.empty?
  end

  def update
    if @fish.update(fish_params)
      redirect_to [ :admin, @fish ]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fish.destroy
    redirect_to admin_fish_index_path
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
