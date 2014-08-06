Rails.application.routes.draw do
  root 'welcome#index'

  # Users and sessions related stuff
  resources :users, except: [:edit, :update] do
    member do
      get :activate
      get :reset_password
      post :reset_password
    end
    collection do
      get :claim_password
      post :claim_password
      get :account
      post :account
    end
  end
  get 'login' => 'user_sessions#new', as: :login
  post 'login' => 'user_sessions#create', as: :log_in
  post 'logout' => 'user_sessions#destroy', as: :logout

end
