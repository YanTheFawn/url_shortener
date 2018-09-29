Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    namespace :api do
      namespace :v1 do
        resources :links, only: [:create, :show], param: :shortened_url
        get 'most_popular', to: 'links#most_popular'
      end
    end
end
