Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :listings, only: %i[index]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :missions, only: %i[index]
    end
  end
end
