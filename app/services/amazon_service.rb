class AmazonService
  KEEPA_KEY = ENV['KEEPA_ENV']
  KEEPA_API_URL = "https://api.keepa.com/product"
  DOMAIN = 2

  class << self
    def fetch_product_info(asin)
      return nil unless asin.present?

      uri = URI(KEEPA_API_URL)
      uri.query = URI.encode_www_form({
        key: KEEPA_KEY,
        domain: DOMAIN,
        asin: asin
      })

      response = Net::HTTP.get_response(uri)

      unless response.is_a?(Net::HTTPSuccess)
        Rails.logger.warn("Keepa API request failed: #{response.code} #{response.body}")
        return nil
      end

      data = JSON.parse(response.body)

      if data['error']
        Rails.logger.error("Keepa API error: #{data['error']['message']}")
        return nil
      end

      product = data['products']&.find { |p| p['asin'] == asin }

      unless product
        Rails.logger.warn("No matching product found for ASIN: #{asin}")
        return nil
      end

      {
        asin: product['asin'],
        brand: product['brand']
      }
    rescue => e
      Rails.logger.error("AmazonService.fetch_product_info failed: #{e.message}")
      nil
    end
  end
end
