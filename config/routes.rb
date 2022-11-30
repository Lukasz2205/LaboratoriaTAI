Rails.application.routes.draw do
  resources :homes
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  root 'home#index'

  resources :books 
  get 'export_books', to: 'books#export_books'

  get '/login', to: 'api/authentication_api#new'
  get '/logout', to: 'api/authentication_api#destroy'


  namespace :api do 
    resources :books_api 
    resources :users_api, only: %i[index show]

    post '/login', to: 'authentication_api#login'
  end 
end
