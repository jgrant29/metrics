Rails.application.routes.draw do
  resources :registered_applications
  resources :events
  devise_for :users
  get 'welcome/index'

  get 'welcome/about'

  root to: 'welcome#index'

  namespace:api, defaults: { format: :json } do
    match '/events', to: 'events#index', via: [:options]
    resources :events, only: [:create]
  end
  
end
