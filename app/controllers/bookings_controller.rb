class BookingsController < ApplicationController
  before_action :set_room

  def index
    @bookings = @room.bookings
  end

  def new
    @booking = @room.bookings.build
  end

  def show
    @booking = @room.bookings.find(params[:id])
  end

  def create
    @booking = @room.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to [@room, @booking], notice: "Your room is successfully booked"
    else
      render :new
    end
  end

  private
  
  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
