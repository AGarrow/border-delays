class StaticController < ApplicationController
  def landing
    @states = Crossing::Geography::STATES
    @provinces = Crossing::Geography::PROVINCES
    @borders = Crossing::Geography::BORDERS
    respond_to do |format|
      format.js {}
      format.html
    end
  end
end
