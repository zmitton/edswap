class UsersController < ApplicationController
  before_action :set_s3_direct_post, only: [ :edit, :create, :new, :create_password_reset]
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

  def update
    @user = User.find(session[:user_id])

    if @user && params[:password]
      @user.password = params[:password]
      @user.save
    end

    if @user.errors.none?
      redirect_to (destination_path || user_path(@user.id))
    else
      flash.now[:notice] = @user.errors.messages
      render 'users/show'
    end
  end

  def reset_password
    @user = User.find_by(password_reset_code: params[:password_reset_code])
    if @user 
      if @user.password_reset_code_expires_at > Time.now
        @user.update(password_reset_code: nil)
        session[:user_id] = @user.id
        flash[:notice] = "You are logged in as #{@user.preferred_email}, Please create a new password"
        redirect_to user_path(@user.id)
      else
        flash[:notice] = "Sorry. The password reset link is expired. please try again"
        redirect_to login_path
      end
    else
      flash[:notice] = "Sorry. Something went wrong. please try again"
      redirect_to login_path
    end
  end

  def create_password_reset
    @user = User.find_by(preferred_email: params[:preferred_email])
    if @user
      @user.create_password_reset_code
      UserMailer.password_reset_email(@user).deliver_now
      flash.now[:notice] = "Please check your email for password reset instructions"
    else
      @user = User.new.setup
      flash.now[:notice] = "Email address not registered"
    end
    render 'users/new'
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
