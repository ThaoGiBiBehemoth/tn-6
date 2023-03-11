class UsersController < ApplicationController
  before_action :authorize, only: [:show, :update]
  before_action :set_user, only: [:show, :update]
   
  # LIST: cái này có thể dùng cho admin về sau, pj này ko cần, để đây thôi =))
  # def index
  #   @users = User.all
  #   render json: @users
  # end

  # SHOW INFO (GET /users/1) 
  def show
    render json: @user
  end

  # UPDATE (PATCH/PUT /users/1)
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: 422
    end
  end

  # SIGNUP/ REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id})
      render json: { user: @user, token: token }, status: 200 
    else
      render json: { error: "Invalid!!!" }, status: 422
    end
  end

  # LOGIN
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

  def set_user
    @user = User.find(params[:id])
  end
end