require 'pbkdf2'

class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.email = params[:user][:email]
    if params[:user][:password] == params[:user][:password_confirmation]
      @user.salt = make_salt
      @user.password_digest = encrypt(params[:user][:password], @user.salt)
      if @user.save
        flash[:success] = 'Good Job!'
        redirect_to @user
      else
        flash.now[:error] = 'What Happened?'
        render :new
      end
    else
      flash.now[:error] = 'Password conirmation does not match password'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def authenticate
    user = User.find_by_email(params[:email])
    if user && user.password_digest == encrypt(params[:password], user.salt)
      flash[:success] = 'Nice!'
      redirect_to user
    else
      flash.now[:error] = 'Failed Log In'
      render :index
    end
  end

  private

  def encrypt(clear_text, salt)
    derived_key = PBKDF2.new do |key|
      key.password = clear_text
      key.salt = salt
      key.iterations = 10000
    end
    return derived_key.hex_string
  end

  def make_salt
    return SecureRandom.hex
  end

end
