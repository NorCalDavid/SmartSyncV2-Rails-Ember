class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      set_current_user(user)
      redirect_to user
    else
      render 'new'
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end

  end

  def show
    @user = User.find(params[:id])
    @counts = counts
  end

  def properties
    @properties = User.find(params[:id]).properties
  end

  def rooms
    @properties = User.find(session[:user_id]).properties
  end

  def devices
    @properties = User.find(session[:user_id]).properties
  end

  private

  def user_params
    params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def counts
    properties = User.find(session[:user_id]).properties
    property_count = properties.length
    room_count = 0
    device_count = 0
    properties.each do |property|
      room_count += property.rooms.count
      device_count += property.devices.count
    end

    return {  properties: property_count,
              rooms: room_count,
              devices: device_count  }
  end

end
