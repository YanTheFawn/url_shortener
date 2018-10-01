Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    require 'sidekiq/web'
    mount Sidekiq::Web => "/sidekiq"

    get '/:shortened_url', to: 'api/v1/links#show'

    namespace :api do
      namespace :v1 do
        get 'links/most_popular', to: 'links#most_popular'
        resources :links, only: [:create]
      end
    end
end
