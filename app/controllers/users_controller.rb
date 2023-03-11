class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id})
      render json: { user: @user, token: token }, status: 200 
    else
      render json: { error: "Invalid!!!" }, status: 422
    end
  end

  def login
    @user = User.find_by(nickname: user_params[:nickname])
    if @user && @user.authenticate(user_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: 200
    else
      render json: { error: 'Invalid nickname or password' }, status: 422 #:unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :password, :email)
  end
end