class Admin::CrittersController < ApplicationController
  def index
    @critters = Critter.all
  end
end
