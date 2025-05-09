class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Later we can pull in Stripe subscription data here
  end

  def billing_portal
    license = current_user.licenses.find(params[:id])

    session = Stripe::BillingPortal::Session.create({
                                                      customer: license.stripe_customer_id,
                                                      return_url: "#{request.base_url}/dashboard"
                                                    })

    redirect_to session.url, allow_other_host: true
  end
end
