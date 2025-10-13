class SeaCreaturesController < ApplicationController
  before_action :set_sea_creature, only: %i[ show ]
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @sea_creatures = SeaCreature.all
  end

  def show
  end

  private
  def set_sea_creature
    @sea_creature = SeaCreature.find(params[:id])
  end
end
