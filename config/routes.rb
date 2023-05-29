Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { 
    sessions: 'users/sessions',  
    omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'pages#home'
  root 'groups#index'

  get '/stores' => 'stores#total'
  post '/groups/:id/store/:id/set_store' => 'stores#set', as: 'set_group_store'

  get 'groups/:id/purchases/done' => 'purchases#done', as: 'purchases_done'
  # store state 轉換
  post 'groups/:id/purchases/:id/finished' => 'purchases#finished', as: 'purchase_finished'
  post 'groups/:id/purchases/:id/refunded' => 'purchases#refunded', as: 'purchase_refunded'
  
  get 'groups/:id/purchases/:id/details' => 'purchases#details', as: 'purchase_details'
  get 'groups/:id/invite' => 'groups#invite', as: 'group_invite'

  get 'groups/:id/member' => 'groups#showmember', as: 'group_member'
  get '/pending_purchases'  => 'groups#pending_purchases', as: 'pending_purchases'

  # 個人團購歷史紀錄
  get '/purchases_history' => 'purchases#history', as: 'purchases_history'

  # openai
  post '/generate_text', to: 'groups#generate_text'

  #LINE Pay confirm
  get '/purchase/:id/confirm', to: 'purchases#confirm'

  # setMode
  get '/set_mode', to: 'application#set_mode'
  post '/set_mode', to: 'application#change_mode'

  namespace :admin do 
    resources :stores do 
      post 'online', as: 'online'
      post 'offline', as: 'offline'
      post 'pending', as: 'pending'
      
      collection do
        get 'purchases', as: 'purchases'
      end
      resources :items

    end
  end

  resources :groups do 
    resource :label, only: [:show, :create]
    resources :stores do
      # resources :items
      resources :comments, only: [:index, :create]
      # get :comments
      # post :comments
    end
    resources :purchases, only: [:new,:create,:index,:show,:destroy] do 
      post 'line_pay', as:'line_pay'
      resources :orders
    end
  end
  
  resources :purchases,except: [:show] do
    resources :orders
  end
  
  resources :messages, only: [:index] do 
    post :read_message
  end
  post '/groups/:id/messages/send' => 'messages#send_message', as: 'message_send'

end
