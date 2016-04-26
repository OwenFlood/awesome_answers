class PasswordResetsMailer < ApplicationMailer

  def send_instructions(user)
    @user = user
    mail(to: @user.email, subject: "Password Resets Instructions")
  end
end
