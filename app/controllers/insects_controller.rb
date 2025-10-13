class InsectsController < ApplicationController
  before_action :set_insect, only: %i[ show ]
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @insects = Insect.all
  end

  def show
  end

  private
  def set_insect
    @insect = Insect.find(params[:id])
  end
end
