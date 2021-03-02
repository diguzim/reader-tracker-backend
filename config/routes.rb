Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      delete '/users/:id', to: 'users#destroy'
      resources :books do
        resources :readings
      end
    end
  end
end
