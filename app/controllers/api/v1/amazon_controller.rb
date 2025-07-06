module Api
    module V1
      class AmazonController < ApplicationController
        skip_before_action :verify_authenticity_token
  
        def product_info
          asin = params[:asin]
  
          return render(json: { error: 'Missing asin' }, status: :bad_request) if asin.blank?
          result = AmazonService.fetch_product_info(asin)
        if result && result[:brand].present?
            Rails.logger.info("Response JSON: #{result.to_json}")
            render json: result, status: :ok
          else
            render json: { error: 'No amazon brand name found' }, status: :not_found
          end
        end
      end
    end
  end
  