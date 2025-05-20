class CheckoutsController < ApplicationController
  def create
    price_id = case params[:plan]
               when 'yearly'
                 'price_1RQrI5K9zwEyspUKySYaBTab'  # Replace with your Stripe yearly subscription Price ID
               when 'lifetime'
                 'price_1RQr7oK9zwEyspUKpB7ciNaa'  # Replace with your Stripe one-time Price ID
               else
                 return render json: { error: 'Invalid plan' }, status: :unprocessable_entity
               end

    mode = params[:plan] == 'yearly' ? 'subscription' : 'payment'

    session_params = {
      payment_method_types: ['card'],
      line_items: [{
                     price: price_id,
                     quantity: 1
                   }],
      mode: mode,
      success_url: "#{root_url}post_checkout?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{root_url}?checkout=cancel"
    }

    # ✅ Add only for lifetime/one-time payments
    session_params[:customer_creation] = 'always' if mode == 'payment'

    session = Stripe::Checkout::Session.create(session_params)

    redirect_to session.url, allow_other_host: true
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    customer = Stripe::Customer.retrieve(session.customer)
    user = User.find_by(email: session.metadata['email'])

    user = User.find_by(email: customer.email)

    if user && user.login_token && user.login_token_valid_until&.future?
      sign_in(user)
      redirect_to dashboard_path
    else
      redirect_to root_path, alert: 'Login failed. Please check your email.'
    end
  end
end
