Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  resources :books

  namespace :api do 
    resources :books_api
    resources :users_api, only: %i[index show]

    post '/login', to: 'authentication_api#login'
  end 

  # get '/*a', to: 'application#not_found'
end
