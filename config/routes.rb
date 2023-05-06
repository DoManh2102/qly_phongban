Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :departments
  resources :user
  # resources :projects
  # resources :user_projects
  resources :projects do
    resources :user_projects
  end
end
