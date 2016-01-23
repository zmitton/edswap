class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  
  def welcome_email(params, to)
    @params = params
    @to = to
    mail(to: 'zacmitton22@gmail.com', subject: 'Welcome to My Awesome Site')
  end

  def password_reset_email(user)
    @user = user
    mail(to: @user.preferred_email, subject: 'Password Reset')
  end
end
