Rails.application.routes.draw do
  resources :quotes, only: :show
end
