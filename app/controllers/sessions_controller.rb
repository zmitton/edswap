class SessionsController < ApplicationController
    # def new
    #   render 'login/index'
    # end


    def create
      # binding.pry
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_path
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path
    end


end
