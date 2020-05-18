Rails.application.routes.draw do
  devise_for :users, :controllers => {
  	:registrations => 'users/registrations',
  	:sessions => 'users/sessions'
  }
  devise_for :admins, :controllers => {
  	:sessions => 'admins/sessions'
  }


  # ここからuserルーティング
  
  namespace :users do
  	root 'home#top'
  	resources :itsms, only: [:index, :show]
  	resources :cart_items, only: [:index, :create, :update]
  	delete 'cart_items/:id/items/:id' => 'users/cart_items#destroy_part'
  	delete 'cart_items/:id' => 'users/cart_items#destroy_cart'
  	resources :orders, only: [:new, :create]
  	post 'orders/confirm' => 'orders#confirm'
  	get 'orders/complete' => 'orders#complete'
  	get 'mypage' => 'users#show'
  	get 'leave' => 'users#leave'
  	get 'hide' => 'users#hide'
  	get 'edit' => 'users#edit'
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
  	resources :users, only: [:index, :show, :edit, :update]
  	resources :orders, only: [:index, :show, :update]
  	patch 'order_items/:id' => 'order_items#update'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
