class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params.key?(:user)
      user = User.from_registration_form(user_params)
    else
      user = User.from_omniauth(env["omniauth.auth"])
    end

    if user
      session[:user_id] = user.id
      redirect_to root_path #redirect preffereably where they came from
    else
      redirect_to root_path #didnt work so do something else
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
