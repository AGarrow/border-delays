class AveragesController < ApplicationController
  # GET /averages
  # GET /averages.json
  def index
    @averages = Average.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @averages }
    end
  end

  # GET /averages/1
  # GET /averages/1.json
  def show
    @average = Average.find(params[:id])
    criteria = @average.attributes.slice('wday', 'hour', 'title', 'bound', 'commercial') 
    @wait_times = WaitTime.where(criteria)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @average }
    end
  end

  # GET /averages/new
  # GET /averages/new.json
  def new
    @average = Average.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @average }
    end
  end

  # GET /averages/1/edit
  def edit
    @average = Average.find(params[:id])
  end

  # POST /averages
  # POST /averages.json
  def create
    @average = Average.new(params[:average])

    respond_to do |format|
      if @average.save
        format.html { redirect_to @average, notice: 'Average was successfully created.' }
        format.json { render json: @average, status: :created, location: @average }
      else
        format.html { render action: "new" }
        format.json { render json: @average.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /averages/1
  # PUT /averages/1.json
  def update
    @average = Average.find(params[:id])

    respond_to do |format|
      if @average.update_attributes(params[:average])
        format.html { redirect_to @average, notice: 'Average was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @average.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /averages/1
  # DELETE /averages/1.json
  def destroy
    @average = Average.find(params[:id])
    @average.destroy

    respond_to do |format|
      format.html { redirect_to averages_url }
      format.json { head :no_content }
    end
  end

  def crossing
    @traveller_us = Average.where(:title => params[:title], :commercial => false, :bound => 'usa')
    @commercial_us = Average.where(:title => params[:title], :commercial => true, :bound => 'usa')
    @traveller_canada = Average.where(:title => params[:title], :commercial => false, :bound => 'canada')
    @commercial_canada = Average.where(:title => params[:title], :commercial => false, :bound => 'canada')
  end
end
