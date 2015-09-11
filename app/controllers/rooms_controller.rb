class RoomsController < ApplicationController

  def index
    @property = Property.find(params[:property_id])
    @rooms = Property.find(params[:property_id]).rooms
  end

  def new
    @property = Property.find(params[:property_id])
    @room = Room.new
  end

  def create
    room = Property.find(params[:property_id]).rooms.new(room_params)
    if room.save
      # Property.find(params[:property_id]).rooms.create!(room: room)
      redirect_to property_rooms_path
    else
      render 'new'
    end

  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
   room = Room.find(params[:id])

   if room.update(room_params)
      redirect_to property_room_path
    else
      render 'edit'
    end
  end

  def destroy
    room = Room.find(params[:id])
    if room.destroy
      redirect_to user_path
    else
      false
      status 417
    end

  end

  private

  def room_params
    params.require(:room).permit(:name, :description)
  end

end

