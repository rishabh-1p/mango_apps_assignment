class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:index, :create]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      render json: @user, status: :created
    else
      render json: @user.errors.full_message, status: :unprocessable_entity
    end
  end

  def show
    render json: @current_user
  end

  def update
    if @current_user.present?
      @current_user.update(user_params)
      render json: @current_user
    else
      render json: @user.errors.full_message, status: :not_found
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
