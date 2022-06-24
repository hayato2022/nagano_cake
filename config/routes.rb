Rails.application.routes.draw do
  root to: "homes#top"

  devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # 管理者側routes
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end

end
