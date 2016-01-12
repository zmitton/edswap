class UsersController < ApplicationController
  def edit
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.register(user_params,location_params)
    # @location = Location.new(location_params.merge(locationeable_type: "User"))

    # begin
    #   ActiveRecord::Base.transaction do
        @user.save#!
        # @location.locationeable_id = @user.id
        # @location.save!
    #   end
    # rescue; end

    if @user.errors.none? # && @location.errors.none?
      session[:user_id] = @user.id
      redirect_to destination_path
    else
      # @user.setup(location_params)
      flash.now[:notice] = @user.errors.messages#.merge(@location.errors.messages)
      render 'sessions/new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private 

  def user_params
    params[:user].permit(:preferred_email, :password, :name, :teacher, :location_attributes)
  end

  def location_params
    params[:user][:location_attributes].permit(:address, :city, :state, :zip, :school_name)
  end
end
