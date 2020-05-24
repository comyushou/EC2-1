Rails.application.routes.draw do
  devise_for :users, :controllers => {
  	:registrations => 'users/registrations',
  	:sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
  devise_for :admins, :controllers => {
  	:sessions => 'admins/sessions'
  }


  # ここからuserルーティング
  
  namespace :users do
  	root 'home#top'
    get 'home/about' => 'home#about'
  	resources :items, only: [:index, :show]
  	resources :cart_items, only: [:index, :create, :update]
    delete 'cart_items' => 'cart_items#destroy_cart', as: 'destroy_cart'  #全削除はIDがいらない
  	delete 'cart_items/:id/items/:id' => 'cart_items#destroy_part'
  	resources :orders, only: [:new, :create]
  	post 'orders/confirm' => 'orders#confirm'
  	get 'orders/complete' => 'orders#complete'
  	get 'mypage' => 'users#show'
    patch 'mypage' => 'users#update'
    get 'mypage/edit' => 'users#edit'
  	get 'leave' => 'users#leave'
  	delete 'hide' => 'users#hide'
  	get 'order_items' => 'orders#index'
  	get 'order_items/:id' => 'order#show'
  	patch '' => 'users/users#update'
  	resources :addresses, only: [:index, :create, :edit, :update,:destroy]
  end

  # ここからadminルーティング
  namespace :admins do
  	get 'top' => 'top#top'
  	resources :items, only: [:new, :index, :create, :show, :edit, :update]
  	resources :genres, only: [:index, :create, :edit, :update]
  	resources :users, only: [:index, :show, :edit]
    patch 'users/:id/edit' => 'users#update'
  	resources :orders, only: [:index, :show, :update]
  	patch 'order_items/:id' => 'order_items#update', as: 'order_item'
  end
  if Rails.env.development?
     mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
