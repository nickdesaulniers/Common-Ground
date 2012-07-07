class RoomsController < ApplicationController
  before_filter :authenticate, :only => [:show]
  
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])

    @users = User.all(:conditions => {:room_id => @room.id})

    @lat_long = getCentroid(@users)

    if @lat_long
      @lat, @long = @lat_long[0], @lat_long[1]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  # This is more like a create method
  def new
    @room = Room.create
    @current_user = User.find(session[:user_id])
    @current_user.room_id = @room.id
    @current_user.save
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end
  
  def sign_in
  end

  private

  def addUser(id)
    @room = Room.find(id)
    @room.increment!(:members)
  end

  def removeUser(id)
    @room = Room.find(id)
    if @room.members > 0
      @room.decrement!(:members)
    end
  end

  def authenticate
    session[:join] = params[:id]
    @user = session[:user_id] && User.find(session[:user_id])
    
    redirect_to signin_url unless @user
    session[:join] = nil
  end
end
