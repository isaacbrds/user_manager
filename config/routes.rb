Rails.application.routes.draw do
  resources :users do 
    collection { post :import }
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
