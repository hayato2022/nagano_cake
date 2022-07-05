Rails.application.routes.draw do

  # 会員側routes
    devise_for :customers, skip: [:passwords], controllers:{
      registrations: "public/registrations",
      sessions: "public/sessions"
    }

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
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
