require 'rest_client'

class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    assertion = params[:assertion]
    res = JSON.parse(RestClient.post 'https://browserid.org/verify',
      audience: "http://#{request.host}:#{request.port}",
      assertion: assertion)
    @user = User.find_or_create_by_email res['email']
    session[:user_id] = @user.id
    Rails.logger.debug "SETTING USER SESSION: #{session[:user_id]}"
    if @user
      if session[:join]
        room = session[:join]
        session[:join] = nil
        render :js => "window.localStorage.setItem('user_id','#{@user.id}');window.window.location = '#{room_path(room)}'"
      else
        render :js => "window.localStorage.setItem('user_id','#{@user.id}');window.window.location = '#{new_room_path}'"
      end
    else
      render nothing: true, status: 400
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    @geo = params[:location]
    if @geo
      @latitude = @geo['latitude']
      @longitude = @geo['longitude']
      @user.latitude = @latitude.to_f
      @user.longitude = @longitude.to_f
      @user.save
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def invite
    @user = User.find_or_create_by_email params['email']
    @room = Room.find params['room']
    @user.room_id = @room.id
    @user.save
    if @user
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
      UsersMailer.invite(@user, @room).deliver
      render nothing: true
    else
      render nothing: true, status: 400
    end
  end
end
