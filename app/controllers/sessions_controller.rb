class SessionsController < ApplicationController
  def new
    @user = User.new
    session[:destination_uri] = params[:destination_uri]
  end

  def create
    if params.key?(:user)
      @user = User.from_login_form(user_params)
    else
      @user = User.from_omniauth(env["omniauth.auth"])
    end

    if @user.errors.none?
      session[:user_id] = @user.id
      redirect_to destination_path #redirect preferably where they came from
    else
      flash.now[:notice] = @user.errors.messages
      render 'sessions/new' #didnt work so do something else
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params[:user].slice(:preferred_email, :password)
  end
end
