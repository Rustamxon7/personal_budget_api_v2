class UserMailer < ApplicationMailer
  def forgot_password(email)
    @user = User.find_by(email: email)
    @token = @user.reset_password_token
    mail(to: email, subject: 'Reset your password')
  end

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the app')
  end
end
