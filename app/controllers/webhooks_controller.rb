class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token


  def stripe
    Rails.logger.info "[Webhook] Reached stripe action"
    render plain: "✅ Webhook endpoint hit", status: :ok
  end
end
