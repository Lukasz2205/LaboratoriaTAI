Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  resources :books
  resources :books_api
  resources :users_api, only: %i[index show]

  post '/login', to: 'authentication_api#login'
  # get '/*a', to: 'application#not_found'
end
