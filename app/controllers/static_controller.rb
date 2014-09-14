class StaticController < ApplicationController
  def landing

    @states = Geography::STATES
    @provinces = Geography::PROVINCES
    @crossings = Crossing.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @crossings }
    end
  end
end
