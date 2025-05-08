class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    # Later we can pull in Stripe subscription data here
  end

  def billing_portal
    session = Stripe::BillingPortal::Session.create({
                                                      customer: current_user.stripe_customer_id,
                                                      return_url: "#{request.base_url}/dashboards/show"
                                                    })

    redirect_to session.url, allow_other_host: true
  end
end
