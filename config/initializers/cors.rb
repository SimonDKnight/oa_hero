Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      # origins 'http://localhost:3000', 'chrome-extension://djnodhhelcikfhjfbpfjajonmgahjlgb' # we need this for CORS issues that we face from the qogita website 
			origins '*'
      resource '*',
        headers: :any,
				methods: %I[get post put patch delete options head]
    end
  end
# 
