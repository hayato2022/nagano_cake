Rails.application.routes.draw do
  root to: "homes#top"

    devise_for :customers


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者側routes
  devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'homes'=> 'homes#top', as: 'homes'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

end
