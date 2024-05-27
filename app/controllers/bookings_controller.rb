class BookingsController < ApplicationController
  before_action :set_room
  def index
    @bookings = @room.bookings
  end

  def new
    @booking = room.booking.build
  end

  def create
    @booking = @room.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to room_bookings_path, notice: "Your room is successfully booked"
    else
      render new
    end
  end

  private
  
  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
