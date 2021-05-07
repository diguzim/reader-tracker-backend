# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      delete '/users/:id', to: 'users#destroy'
      resources :books do
        resources :readings
      end
      get '/authors/:id/books', to: 'authors#books'
      put '/authors/:id/books/:book_id', to: 'authors#add_authorship'
      delete '/authors/:id/books/:book_id', to: 'authors#destroy_authorship'

      resources :authors
      get '/books/:id/authors', to: 'books#authors'
      put '/books/:id/authors/:author_id', to: 'books#add_authorship'
      delete '/books/:id/authors/:author_id', to: 'books#destroy_authorship'
    end
  end
end
