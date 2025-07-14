class BrandLabelService
    SUPABASE_URL = "https://kzdzolpbuibvwzcvwido.supabase.co"
    SUPABASE_API_KEY = ENV['SUPABASE_KEY']
		# this can now be reusable within qogita calls too 
    class << self
        def fetch_labels(brand_name)
					return nil unless brand_name.present?
				
					words = brand_name.split(/\s+/)[0, 2]
					partial_name = words.join(' ')
					filter_value = "%#{partial_name}%"  # also works for partial searches such as Al Haramain Perfumes - where the supabase name is only Al Haramain and special characters such as Lancôme
					
					uri = URI("#{SUPABASE_URL}/rest/v1/restricted_brands")
					uri.query = URI.encode_www_form({
						select: 'name,transparency,intellectual_property,parallel_import,private_label,hard_gated,general_info',
						name: "ilike.#{filter_value}"
					})
					response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
						request = Net::HTTP::Get.new(uri)
						request['apikey'] = SUPABASE_API_KEY
						request['Authorization'] = "Bearer #{SUPABASE_API_KEY}"
						request['Content-Type'] = 'application/json'
						request['Accept-Encoding'] = 'identity'
						http.request(request)
					end
					return nil unless response.is_a?(Net::HTTPSuccess)
				
					data = JSON.parse(response.body)
					brand = data.first
					return nil unless brand
				
					{
						transparency: brand['transparency'],
						intellectualProperty: brand['intellectual_property'],
						parallelImport: brand['parallel_import'],
						privateLabel: brand['private_label'],
						hardGated: brand['hard_gated'],
						generalInfo: brand['general_info']
					}
				rescue => e
					Rails.logger.error("BrandLabelService.fetch_labels error: #{e.message}")
					nil
				end
    end
  end
  