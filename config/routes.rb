Rails.application.routes.draw do
  resources :orders, only: [:create, :show]
end
