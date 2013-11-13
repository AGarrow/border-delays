class WaitTimesController < ApplicationController
  # GET /wait_times
  # GET /wait_times.json
  def index
    @wait_times = WaitTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wait_times }
    end
  end

  # GET /wait_times/1
  # GET /wait_times/1.json
  def show
    @wait_time = WaitTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wait_time }
    end
  end

  # GET /wait_times/new
  # GET /wait_times/new.json
  def new
    @wait_time = WaitTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wait_time }
    end
  end

  # GET /wait_times/1/edit
  def edit
    @wait_time = WaitTime.find(params[:id])
  end

  # POST /wait_times
  # POST /wait_times.json
  def create
    @wait_time = WaitTime.new(params[:wait_time])

    respond_to do |format|
      if @wait_time.save
        format.html { redirect_to @wait_time, notice: 'Wait time was successfully created.' }
        format.json { render json: @wait_time, status: :created, location: @wait_time }
      else
        format.html { render action: "new" }
        format.json { render json: @wait_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wait_times/1
  # PUT /wait_times/1.json
  def update
    @wait_time = WaitTime.find(params[:id])

    respond_to do |format|
      if @wait_time.update_attributes(params[:wait_time])
        format.html { redirect_to @wait_time, notice: 'Wait time was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wait_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wait_times/1
  # DELETE /wait_times/1.json
  def destroy
    @wait_time = WaitTime.find(params[:id])
    @wait_time.destroy

    respond_to do |format|
      format.html { redirect_to wait_times_url }
      format.json { head :no_content }
    end
  end
end
