Rails.application.routes.draw do
  resources :homes
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  root 'home#index'

  resources :books

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  namespace :api do 
    resources :books_api
    resources :users_api, only: %i[index show]

    post '/login', to: 'authentication_api#login'
  end 
end
