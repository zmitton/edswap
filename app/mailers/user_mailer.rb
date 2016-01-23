class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  
  def welcome_email(@user)
    @user = user
    mail(to: @user.preferred_email, subject: 'Welcome to Edswap')
  end

  def password_reset_email(user)
    @user = user
    mail(to: @user.preferred_email, subject: 'Password Reset')
  end

  def listing_reply(params, to_temp_address, from_temp_address)
    @params = params
    @to_temp_address = to_temp_address
    @from_temp_address = from_temp_address
    mail(to: @to_temp_address.real_email_address, from: @from_temp_address.temp_email_address, subject: "Edswap listing Response: #{params[:headers]['Subject']}")
  end
end
