Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :passwords]
  get "dashboard", to: "dashboards#index"

  # authenticated :user do
  #   root "dashboards#show", as: :authenticated_root
  # end
  #
  # unauthenticated do
  #   root "home#index" # Or whatever your public landing page is
  # end

  root "home#index"
  get 'retailer_list', to: 'home#retailer_list'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  post "/checkouts", to: "checkouts#create"
  post '/webhooks/stripe', to: 'webhooks#stripe'
  get 'post_checkout', to: 'checkouts#success'
  get 'billing_portal/:id', to: 'dashboards#billing_portal', as: :billing_portal
  get '/users/sign_up', to: redirect('/users/sign_in')

  get '/magic_login/:token', to: 'magic_links#show', as: :magic_login
  post '/send_magic_link', to: 'magic_links#create', as: :send_magic_link
  namespace :api do
    namespace :v1 do
      post 'qogita_product_info', to: 'qogita#product_info'
      post 'amazon_product_info', to: 'amazon#product_info'
    end
  end
end
