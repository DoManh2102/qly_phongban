Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :departments
  resources :user, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # resources :projects
  # resources :user_projects
  resources :departments do
    resources :users_department, only: [:edit, :update]
  end

  resources :projects do
    resources :user_projects
  end
end
