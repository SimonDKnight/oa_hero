class MagicLinksController < ApplicationController
  def show
    user = User.find_by(login_token: params[:token])

    if user && user.login_token_valid_until&.future?
      sign_in(user)
      user.update(login_token: nil, login_token_valid_until: nil)
      redirect_to dashboard_path
    else
      redirect_to root_path, alert: "Login link expired or invalid."
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.update(
        login_token: SecureRandom.hex(20),
        login_token_valid_until: 10.minutes.from_now
      )
      UserMailer.magic_link(user).deliver_later
    end
    redirect_to root_path, notice: "If your email exists, you'll receive a login link."
  end
end
