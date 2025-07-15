module Api
  module V1
    class QogitaController < ApplicationController
      skip_before_action :verify_authenticity_token

      def product_info
        fid = params[:fid]
        slug = params[:slug]

        return render(json: { error: "Missing fid or slug" }, status: :bad_request) if fid.blank? || slug.blank?

        product = QogitaService.fetch_product_info(fid:, slug:)

        if product.present? && product[:brand].present?
          labels = BrandLabelService.fetch_labels(product[:brand])
          brand_info_and_labels_response = product.merge(labels:)

          Rails.logger.info("Qogita Response JSON: #{brand_info_and_labels_response.to_json}")
          render json: { success: true, data: brand_info_and_labels_response }, status: :ok
        else
          render json: { error: "No matching product found" }, status: :not_found
        end
      end
    end
  end
end
