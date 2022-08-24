Rails.application.routes.draw do
  devise_for :users
  root to: "tenements#index"

  resources :tenements
  resources :bookings

  namespace :hosting do
    resources :tenements
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
