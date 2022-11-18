Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :artworks, only: %i[index show new create destroy] do
    resources :offers, only: %i[new create]
  end

  resources :users do
    resources :artworks
  end

  resources :offers, only: %i[index show]
end
