Rails.application.routes.draw do

  root 'gossips#index'
  get 'team', to: 'static_pages#team'
  get 'contact', to: 'static_pages#contact'
  #get 'city', to: 'static_pages#city'
  #get 'welcome(/:first_name)', to: 'pages#welcome', as: 'welcome'
  resources :gossips do
    resources :users, only:[:show, :new, :create]
    resources :likes, only:[:new, :create, :destroy]
  end
  resources :cities, only:[:show]
  resources :users
  resources :sessions,only:[:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
