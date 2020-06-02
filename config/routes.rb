Rails.application.routes.draw do
  root to: "toppages#index"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:create]
  resources :stores do 
    collection do 
      post :import 
    end 
  end 
  resources :weeks do
    collection do
      get :pdf
    end
  end
end
