# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'tenements#index'

  resources :tenements, only: %i[index show]
  resources :bookings, only: %i[index create destroy]

  namespace :hosting do
    resources :tenements, only: %i[index new create show destroy]
  end
end
