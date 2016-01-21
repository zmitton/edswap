class UsersController < ApplicationController
  before_action :set_s3_direct_post, only: [ :edit, :create, :new] # , :update
  before_action :allow_access_control

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def new
    @user = User.new.setup
    session[:destination_uri] = params[:destination_uri]
  end

  def create
    @user = User.register(user_params,location_params)
    @user.save

    if @user.errors.none?
      session[:user_id] = @user.id
      redirect_to (destination_path || user_path(@user.id))
    else
      flash.now[:notice] = @user.errors.messages
      render 'users/new'
    end
  end

  private 

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end

  def user_params
    params[:user].permit(:preferred_email, :password, :name, :teacher, :image_path, :location_attributes)
  end

  def location_params
    params[:user][:location_attributes].permit(:address, :city, :state, :zip, :school_name)
  end
end
