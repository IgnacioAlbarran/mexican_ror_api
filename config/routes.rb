Rails.application.routes.draw do
  resources :venues

  get '/platform_a_data', to: 'venues#platform_a_data'
  get '/platform_b_data', to: 'venues#platform_b_data'
  get '/platform_c_data', to: 'venues#platform_c_data'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
