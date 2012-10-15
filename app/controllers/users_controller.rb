class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.email = params[:user][:email]
    @user.password_digest = params[:user][:password]
    if @user.save
      redirect_to @user
      flash[:success] = 'Good Job!'
    else
      render :new
      flash[:error] = 'What Happened?'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def authenticate
    user = User.find_by_email(params[:email])
    if user
      flash[:success] = 'Nice!'
      redirect_to user
    else
      flash[:error] = 'Failed Log In'
      render :index
    end
  end

end
