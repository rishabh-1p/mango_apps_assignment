class MoviesController < ApplicationController
  skip_before_action :authorize_request

  def index
    @movies = Movie.all
    render json: @movies
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save!
      render json: @movie, status: :created
    else
      render json: @movie.errors.full_message, status: :unprocessable_entity
    end
  end

  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  rescue ActiveRecord::RecordNotFound => error
    render json: { error: error.message }, status: :not_found
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :description, :genre, :release_date, :language)
  end
end
