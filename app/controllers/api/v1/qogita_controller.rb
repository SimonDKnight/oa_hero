module Api
    module V1
      class QogitaController < ApplicationController
        skip_before_action :verify_authenticity_token
  
        def product_info
          fid = params[:fid]
          slug = params[:slug]
  
          return render(json: { error: 'Missing fid or slug' }, status: :bad_request) if fid.blank? || slug.blank?
  
        if (result = QogitaService.fetch_product_info(fid: fid, slug: slug))
            Rails.logger.info("Response JSON: #{result.to_json}")
            render json: result, status: :ok
          else
            render json: { error: 'No matching product found' }, status: :not_found
          end
        end
      end
    end
  end
  