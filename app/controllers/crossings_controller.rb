require 'geography'
class CrossingsController < ApplicationController
  # GET /crossings
  # GET /crossings.json
  def index
    # @crossings = {}
    # Crossing.all.each do |c|
    #   @crossings[c.province][c.state] += c
    # end

    @states = Geography::STATES
    @provinces = Geography::PROVINCES
    @crossings = Crossing.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @crossings }
    end
  end

  def filter_crossings
    conditions = {}
    conditions['state'] = params[:state] if params[:state]
    conditions['province'] = params[:province] if params[:province]
    crossings = Crossing.find(:all, :conditions => conditions)
    if crossings.empty? 
      crossings.push({:title => "Sorry,", :location => "there are no crossings between #{conditions['state']} and #{conditions['province']}"})
    end
    render json: crossings
  end
  # GET /crossings/1
  # GET /crossings/1.json
  def show
    @crossing = Crossing.find(params[:id])
    @traveller_us = Average.where(:crossing_id => @crossing.id, :commercial => false, :bound => 'usa').order(:wday , :hour)
    @commercial_us = Average.where(:crossing_id => @crossing.id, :commercial => true, :bound => 'usa').order(:wday , :hour)
    @traveller_canada = Average.where(:crossing_id => @crossing.id, :commercial => false, :bound => 'canada').order(:wday, :hour)
    @commercial_canada = Average.where(:crossing_id => @crossing.id, :commercial => false, :bound => 'canada').order(:wday, :hour)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @crossing }
    end
  end

  def chart_data
    crossing = Crossing.find(params[:id])
    data = crossing.chart_data(params[:bound], params[:commercial], params[:wday])
    response = {title: crossing.title, bound: params[:bound], data: data}
    if (params[:wday] == '6' or params[:wday] == '0' or params[:wday] =='1') and Time.now < Date.parse('2016-09-12 00:00:00') then
      response[:message] = "Due to a brief outage, certain wait times for this day last week are not available, sorry!"
    end
    respond_to do |format|
      format.js { render json: response}
      format.json { render json: response}  
    end
    
  end

  # GET /crossings/new
  # GET /crossings/new.json
  def new
    @crossing = Crossing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @crossing }
    end
  end

  # GET /crossings/1/edit
  def edit
    @crossing = Crossing.find(params[:id])
  end

  # POST /crossings
  # POST /crossings.json
  def create
    @crossing = Crossing.new(params[:crossing])

    respond_to do |format|
      if @crossing.save
        format.html { redirect_to @crossing, notice: 'Crossing was successfully created.' }
        format.json { render json: @crossing, status: :created, location: @crossing }
      else
        format.html { render action: "new" }
        format.json { render json: @crossing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /crossings/1
  # PUT /crossings/1.json
  def update
    @crossing = Crossing.find(params[:id])

    respond_to do |format|
      if @crossing.update_attributes(params[:crossing])
        format.html { redirect_to @crossing, notice: 'Crossing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @crossing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crossings/1
  # DELETE /crossings/1.json
  def destroy
    @crossing = Crossing.find(params[:id])
    @crossing.destroy

    respond_to do |format|
      format.html { redirect_to crossings_url }
      format.json { head :no_content }
    end
  end
end
