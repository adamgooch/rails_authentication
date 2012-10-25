class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = 'Good Job!'
      redirect_to @user
    else
      flash.now[:error] = 'What Happened?'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def authenticate
    user = User.find_by_email(params[:email])
    if user.try(:authenticate, params[:password])
      flash[:success] = 'Nice!'
      redirect_to user
    else
      flash.now[:error] = 'Failed Log In'
      render :index
    end
  end

end
