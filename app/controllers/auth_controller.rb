class AuthController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :authorize_request, only: :create

  def create
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private
  def auth_params
    params.require(:user).permit!(:email, :password)
  end
end
