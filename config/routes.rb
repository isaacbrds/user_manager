Rails.application.routes.draw do
  devise_scope :user do
    get '/users/sign_in' => 'devise/sessions#new'
    get '/users/sign_up' => 'registrations#new'
  end
  resources :users, :controller => "users" do 
    collection { post :import }
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  
  root to: 'dashboard#index'
  
  get '/admins_list' => 'dashboard#index_admin'
  get '/clients_list' => 'dashboard#index_client'
end
