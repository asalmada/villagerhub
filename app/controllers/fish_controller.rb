class FishController < ApplicationController
  before_action :set_fish, only: %i[ show ]
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @fish = Fish.all
  end

  def show
  end

  private
  def set_fish
    @fish = Fish.find(params[:id])
  end
end
