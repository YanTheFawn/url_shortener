Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    require 'sidekiq/web'
    mount Sidekiq::Web => "/sidekiq"

    namespace :api do
      namespace :v1 do
        resources :links, only: [:create, :show], param: :shortened_url
        get 'links/most_popular', to: 'links#most_popular'
      end
    end
end
