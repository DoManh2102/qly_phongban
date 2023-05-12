Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :departments
  resources :user, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      get :change_password
      get :edit_info
      patch :update_info
    end
  end

  resources :departments do
    resources :users_department, only: [:edit, :update]
  end

  resources :departments do
    resources :projects_department, only: [:edit, :update]
  end

  resources :projects do
    resources :user_projects
  end

  scope "(:locale)", locale: /en|vi/ do
  end
end
