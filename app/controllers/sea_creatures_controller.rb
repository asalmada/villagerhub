class SeaCreaturesController < ApplicationController
  include CritterParams
  before_action :set_sea_creature, only: %i[ show edit update destroy ]
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @sea_creatures = SeaCreature.all
  end

  def show
  end

  def new
    @sea_creature = SeaCreature.new
    @sea_creature.availabilities.build
  end

  def create
    @sea_creature = SeaCreature.new(sea_creature_params)
    if @sea_creature.save
      redirect_to @sea_creature
    else
      render :new
    end
  end

  def edit
    @sea_creature.availabilities.build if @sea_creature.availabilities.empty?
  end

  def update
    if @sea_creature.update(sea_creature_params)
      redirect_to @sea_creature
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sea_creature.destroy
    redirect_to sea_creatures_path
  end

  private
  def set_sea_creature
    @sea_creature = SeaCreature.find(params[:id])
  end
  def sea_creature_params
    params.require(:sea_creature).permit(
      *permitted_critter_params,
      :movement_speed
    )
  end
end
