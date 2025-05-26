class UserMailer < ApplicationMailer
  default from: "hello@oahero.com" # change as needed

  def magic_link(user)
    @user = user
    @login_url = magic_login_url(token: user.login_token)
    mail(to: @user.email, subject: "Your Magic Login Link for OA Hero")
  end

  def subscription_confirmation(user, license)
    @user = user
    @license = license
    @download_link = ENV["OA_HERO_DOWNLOAD_URL"]
    mail(to: @user.email, subject: "🎉 Welcome to OA Hero — Your Subscription Is Active")
  end
end
