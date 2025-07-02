# require 'net/http'
# require 'uri'
# require 'json'

class QogitaService
  QOGITA_API_URL = "https://api.qogita.com"
  USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) " \
               "AppleWebKit/537.36 (KHTML, like Gecko) " \
               "Chrome/114.0.0.0 Safari/537.36"
  HEADERS = {
    'Content-Type' => 'application/json',
    'User-Agent' => USER_AGENT
  }
  class << self
    def fetch_product_info(fid:, slug:)
      token = access_token
      return nil unless token
    
      # performs the search by slug and then filter by fid after authentication successfull
      uri = URI("#{QOGITA_API_URL}/variants/offers/search/")
      uri.query = URI.encode_www_form(query: slug)
      request = Net::HTTP::Get.new(uri, {
        'Authorization' => "Bearer #{token}",
        'Accept' => 'application/json',
        'User-Agent' => USER_AGENT
      })
    
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
    
      return nil unless response.is_a?(Net::HTTPSuccess)
    
      data = JSON.parse(response.body)
      matched_product = data['results']&.find { |product| product['fid'] == fid }

      return Rails.logger.warn("No matching product found for fid: #{fid}") && nil unless matched_product

      {
        brandName: matched_product['brandName'],
        gtin: matched_product['gtin']
      }
    rescue => e
      Rails.logger.error("Qogita Service fetch_product_info failed: #{e.message}")
      nil
    end

    private

    def access_token
      authenticate! if @qogita_token.nil? || token_expired?
      @qogita_token
    end

    def authenticate!
      uri = URI("#{QOGITA_API_URL}/auth/login/")
      auth_request = Net::HTTP::Post.new(uri, HEADERS)

      auth_request.body = {
        email: ENV['QOGITA_EMAIL'],
        password: ENV['QOGITA_PASSWORD']
      }.to_json
    
      auth_response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(auth_request)
      end
    
      unless auth_response.is_a?(Net::HTTPSuccess)
        raise "Qogita authentication failed: #{auth_response.body}"
      end
    
      data = JSON.parse(auth_response.body)
      @qogita_token = data["accessToken"]
      @token_expires_at = Time.now + 4.minutes #qogita tokens expire very often at around 5 mins
    
      Rails.logger.info("Qogita token refreshed")
    end
    

    def token_expired?
      @token_expires_at.nil? || Time.now >= @token_expires_at
    end
  end
end
