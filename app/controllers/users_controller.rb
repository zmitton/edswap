class UsersController < ApplicationController
  def edit
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.register(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to destination_path
    else
      flash[:notice] = @user.errors
      render 'sessions/new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private 

  def user_params
    params[:user].slice(:preferred_email, :password, :name)
  end
end
