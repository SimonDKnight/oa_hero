class UserMailerPreview < ActionMailer::Preview
  def magic_link
    user = User.first || User.create!(
      email: "preview@example.com",
      password: SecureRandom.hex(8),
      login_token: SecureRandom.hex(20),
      login_token_valid_until: 10.minutes.from_now
    )

    UserMailer.magic_link(user)
  end
end
