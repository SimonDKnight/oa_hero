class UserMailer < ApplicationMailer
  default from: "hello@oahero.com" # change as needed

  def magic_link(user)
    @user = user
    @login_url = magic_login_url(token: user.login_token)
    mail(to: @user.email, subject: "Your Magic Login Link for OA Hero")
  end
end
