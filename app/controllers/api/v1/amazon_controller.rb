module Api
    module V1
      class AmazonController < ApplicationController
        skip_before_action :verify_authenticity_token
  
        def product_info
          asin = params[:asin]
  
          if asin.blank?
            render json: { success: false, error: 'Missing ASIN' }, status: :bad_request
            return
          end
  
          product = AmazonService.fetch_product_info(asin)
  
          if product.present? && product[:brand].present?
            labels = BrandLabelService.fetch_labels(product[:brand])
            brand_info_and_labels_response = product.merge(labels:)
  
            Rails.logger.info("Amazon Response JSON: #{brand_info_and_labels_response.to_json}")
            render json: { success: true, data: brand_info_and_labels_response }, status: :ok
          else
            render json: { success: false, error: 'No brand info found for ASIN' }, status: :not_found
          end
        end
      end
    end
  end
  