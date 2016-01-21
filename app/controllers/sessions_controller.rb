class SessionsController < ApplicationController
  before_action :set_s3_direct_post, only: [:create]
  before_action :allow_access_control

  def create
    if params.key?(:user)
      @user = User.from_login_form(user_params)
    else
      @user = User.from_omniauth(env["omniauth.auth"])
    end

    if @user.errors.none?
      session[:user_id] = @user.id
      redirect_to (destination_path || root_path)#redirect preferably where they came from
    else
      flash.now[:notice] = @user.errors.messages
      render 'users/new' #didnt work so do something else
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end

  def user_params
    params[:user].slice(:preferred_email, :password)
  end
end
