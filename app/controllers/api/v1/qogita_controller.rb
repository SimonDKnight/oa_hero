module Api
    module V1
      class QogitaController < ApplicationController
        protect_from_forgery with: :null_session # for API only
  
        def product_info
          fid = params[:fid]
          slug = params[:slug]
  
          return render(json: { error: 'Missing fid or slug' }, status: :bad_request) if fid.blank? || slug.blank?
  
        if (result = QogitaService.fetch_product_info(fid: fid, slug: slug))
            render json: result, status: :ok
          else
            render json: { error: 'No matching product found' }, status: :not_found
          end
        end
      end
    end
  end
  