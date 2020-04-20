Rails.application.routes.draw do
  root to: "toppages#index"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :stores
  resources :weeks do
    collection do
      get :pop
    end
  end
end
