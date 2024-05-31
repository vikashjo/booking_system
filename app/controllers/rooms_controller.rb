class RoomsController < ApplicationController
  
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.create(room_params)
    if @room.save
      redirect_to @room, notice: "Room was successfully created."
    else
      render :new
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url, notice: "Room was successfully deleted."
  end
  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :availability, images: [])
  end
end 