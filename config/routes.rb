Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'pages#home'
  root 'groups#index'

  get '/stores' => 'stores#total'
  post '/groups/:id/store/:id/set_store' => 'stores#set', as: 'set_group_store'

  get 'groups/:id/purchases/done' => 'purchases#done', as: 'purchases_done'
  post 'groups/:id/purchases/:id/finished' => 'purchases#finished', as: 'purchase_finished'
  post 'groups/:id/purchases/:id/refunded' => 'purchases#refunded', as: 'purchase_refunded'

  namespace :admin do 
    resources :stores do 
      resources :items

    end
  end

  resources :groups do 
    resources :stores do
      # resources :items
    end
    resources :purchases, only: [:new,:create,:index]
    
  end
  
  resources :purchases do
    resources :orders
  end

end
