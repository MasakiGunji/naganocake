Rails.application.routes.draw do
  # devise_for :customers
  # devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'public/homes#top'
  get 'about', to: 'public/homes#about'
  delete 'cart_items/destroy_all', to: 'public/cart_items#destroy_all'

  get '/customers/my_page', to: 'public/customers#show'
  get '/customers/edit', to: 'public/customers#edit'
  patch '/customers', to: 'public/customers#update'
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe'
  patch '/customers/withdraw', to: 'public/customers#withdraw'

  post '/orders/confirm', to: 'public/orders#confirm'
  get '/def', to: 'public/orders#complete'


  namespace :admins do
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  scope module: "public" do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:index, :new, :create, :show]
  end


  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }


end
