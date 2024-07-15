class BookingsController < ApplicationController
  skip_before_action :authorize_request, only: :index

  def index
    @bookings = Booking.all
    render json: @bookings
  end

  def create
    showtime = Showtime.find(params[:showtime_id])
    available_seats = showtime.available_seats

    if available_seats.empty?
      render json: { error: 'No available seats for this showtime.' }, status: :unprocessable_entity
    else
      seat_number = allocate_seat(showtime)
      booking = showtime.bookings.create(seat_number: seat_number, user_id: @current_user.id)
      render json: { message: "Booking confirmed! Seat #{seat_number} for #{showtime.movie.name} at #{showtime.date}." }
    end
  end

  def destroy
    booking = Booking.find(params[:id])
    showtime = booking.showtime
    seat_number = booking.seat_number
    if booking.destroy
      render json: { message: "Booking canceled for seat #{seat_number}." }
    else
      render json: { error: 'Unable to cancel booking.' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => error
    render json: { error: error.message }, status: :not_found
  end

  private

  def allocate_seat(showtime)
    showtime.available_seats.first
  end
end
