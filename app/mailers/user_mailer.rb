class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  
  def welcome_email(params)
    mail(to: 'zacmitton22@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
