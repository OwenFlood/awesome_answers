class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user
      user.generate_password_reset_data
      PasswordResetsMailer.send_instructions(user).deliver_later
    end
  end

  def edit
    @user = User.find_by_password_reset_token! params[:id]
  end

  def update
    @user = User.find_by_password_reset_token! params[:id]
    user_params = params.require(:user).permit(:password, :password_confirmation)
    if @user.password_reset_expired?
      redirect_to new_password_reset_path, alert: "password reset has expired"
    elsif @user.update user_params
      sign_in(@user)
      redirect_to root_path, notice: "Password reset succesfully"
    else
      render :edit
    end
  end
end
