Rails.application.routes.draw do

  namespace :public do
    get 'cart_items/index'
  end
  # 会員側routes
    devise_for :customers, skip: [:passwords], controllers:{
      registrations: "public/registrations",
      sessions: "public/sessions"
    }

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :orders, only: [:new]
    # public/customers
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdrawal" => "customers#withdrawal"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者側routes
  devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"

    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update, ]
    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show, :update] do
      resources :orders_details, only: [:update]
    end

  end

end
