class ShowtimesController < ApplicationController
  skip_before_action :authorize_request

  def index
    @showtimes = Showtime.find_by(movie_id: params[:movie_id])
    render json: @showtimes
  end

  def create
    @showtime = Showtime.new(showtime_params.merge(movie_id: params[:movie_id]))
    if @showtime.save!
      render json: @showtime, status: :created
    else
      render json: @showtime.errors.full_message, status: :unprocessable_entity
    end
  end

  def show
    @showtime = Showtime.find(params[:id])
    render json: @showtime
  rescue ActiveRecord::RecordNotFound => error
    render json: { error: error.message }, status: :not_found
  end

  private

  def showtime_params
    params.require(:showtime).permit(:date, :start_time, :end_time)
  end
end
