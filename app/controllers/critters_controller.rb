class CrittersController < ApplicationController
  def index
    @critters = Critter.all
  end

  def show
    @critter = Critter.find(params[:id])
  end
end
