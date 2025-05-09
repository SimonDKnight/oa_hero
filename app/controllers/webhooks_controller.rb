class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    secret = ENV['STRIPE_WEBHOOK_SECRET']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, secret)
      Rails.logger.info "[Webhook] Received event: #{event['type']}"
    rescue JSON::ParserError => e
      Rails.logger.error "[Webhook] Invalid JSON: #{e.message}"
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error "[Webhook] Signature mismatch: #{e.message}"
      return head :bad_request
    end


    case event['type']
    when 'checkout.session.completed'
      session = event['data']['object']
      customer = Stripe::Customer.retrieve(session['customer'])

      email = customer['email']
      # name = customer['name'] || ''  # full name
      user = User.find_or_create_by(email: email) do |u|
        u.password = SecureRandom.hex(10)
      end

      plan_type = session.mode == 'subscription' ? 'yearly' : 'lifetime'
      license_key = "#{plan_type}-#{SecureRandom.hex(10)}"
      customer_name = customer.name

      user.licenses.create!(
        license_key: license_key,
        plan: plan_type,
        stripe_customer_id: session.customer,
        stripe_subscription_id: session.subscription,
        expires_at: plan_type == 'yearly' ? 1.year.from_now : nil
      )
      user.update(
        login_token: SecureRandom.hex(20),
        login_token_valid_until: 10.minutes.from_now,
        name: customer_name
      )
    end

    render json: { message: 'success' }, status: 200
  end
end
