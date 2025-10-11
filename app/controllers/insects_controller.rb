class InsectsController < ApplicationController
  include CritterParams
  before_action :set_insect, only: %i[ show edit update destroy ]

  def index
    @insects = Insect.all
  end

  def shadow
  end

  def new
    @insect = Insect.new
    @insect.availabilities.build
  end

  def create
    @insect = Insect.new(insect_params)
    if @insect.save
      redirect_to @insect
    else
      # Rails.logger.debug(@insect.errors.full_messages)
      render :new
    end
  end

  def edit
    @insect.availabilities.build if @insect.availabilities.empty?
  end

  def update
    if @insect.update(insect_params)
      redirect_to @insect
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @insect.destroy
    redirect_to insects_path
  end

  private
  def set_insect
    @insect = Insect.find(params[:id])
  end
  def insect_params
    params.require(:insect).permit(
      *permitted_critter_params,
      :spawn_location,
      :spawn_weather
    )
  end
end
