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
    @user.save
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
  end
end
