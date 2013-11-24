class AlbumsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  # GET /albums
  # GET /albums.json
  def index
     @albums = Album.order("created_at desc").page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])
    @albums_count = Album.count
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = current_user.albums.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = current_user.albums.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = current_user.albums.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to  @album,  notice: 'You created a #Album. Now share your #album around the internets' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @Album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = current_user.albums.find(params[:id])

    respond_to do |format|
      if @Album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @Album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = current_user.albums.find(params[:id])
    @Album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end

  def up_vote
    @album = Album.find params[:id]
    current_user.up_vote(@album)
    redirect_to album_path(@album)
  end

end
