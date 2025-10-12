class CrittersController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @critters = Critter.all
  end
end
