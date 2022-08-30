Rails.application.routes.draw do
  
  root to: "questions#index"
  #resources :users, only: %i[new create edit update destroy show]
  resources :users, exept: %i[index] # все пути кроме index
  resource :session, only: %i[new create destroy]
  resources :questions do
    member do 
    put :hide
    patch :hide
    end 
  end
end
