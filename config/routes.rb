Rails.application.routes.draw do
#toppages route
  root to:"toppages#index"
  
#login routes 
  get "login", to:"sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  #もしくは「resources :session, only: [:new,:create,:#destroy]でもOK」


#users routes
  get "signup", to: "users#new"
  resources :users, only: [:new, :index, :show, :create] do
    member do
      get :followings
      get :followers
    end
  end
 
#microposts routes 
  resources :microposts, only: [:create,:destroy]
  
#relationships routes 
  resources :relationships, only:[:create,:destroy]
  
end
