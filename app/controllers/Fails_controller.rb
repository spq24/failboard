class FailsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  # GET /fails
  # GET /fails.json
  def index
    if params[:tag]
     @fails = Fail.tagged_with(params[:tag]).page params[:page]
    else
     @fails = Fail.order("created_at desc").page params[:page]
    end


    @tags = Fail.tag_counts_on(:tags, :limit => 30, :order => "count desc")

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @fails }
    end
  end

  # GET /fails/1
  # GET /fails/1.json
  def show
    @fail = Fail.find(params[:id])
    @fails_count = Fail.count
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fail }
    end
  end

  # GET /fails/new
  # GET /fails/new.json
  def new
    @fail = current_user.fails.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fail }
    end
  end

  # GET /fails/1/edit
  def edit
    @fail = current_user.fails.find(params[:id])
  end

  # POST /fails
  # POST /fails.json
  def create
    @fail = current_user.fails.new(params[:fail])

    respond_to do |format|
      if @fail.save
        format.html { redirect_to  @fail,  notice: 'You created a #Fail. Now share youre #Fail around the internets' }
        format.json { render json: @fail, status: :created, location: @fail }
      else
        format.html { render action: "new" }
        format.json { render json: @fail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fails/1
  # PUT /fails/1.json
  def update
    @fail = current_user.fails.find(params[:id])

    respond_to do |format|
      if @fail.update_attributes(params[:fail])
        format.html { redirect_to @fail, notice: 'fail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fails/1
  # DELETE /fails/1.json
  def destroy
    @fail = current_user.fails.find(params[:id])
    @fail.destroy

    respond_to do |format|
      format.html { redirect_to fails_url }
      format.json { head :no_content }
    end
  end

  def up_vote
    @fail = Fail.find params[:id]
    current_user.up_vote(@fail)
    redirect_to fail_path(@fail)
  end

end
