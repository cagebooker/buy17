Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'pages#home'
  root 'groups#index'

  get '/stores' => 'stores#total'

  namespace :admin do 
    resources :stores do 
      resources :items
    end
  end

  resources :groups do 
    resources :stores do
      # resources :items
    end  
  end
  
  resources :purchases do
    resources :orders
  end

end
