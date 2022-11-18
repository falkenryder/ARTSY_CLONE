Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :artworks, only: %i[index show new create destroy] do
    resources :offers, only: %i[index new create update]
  end

  resources :users do
    resources :artworks
    resources :offers, only: %i[index update]
  end

  resources :offers, only: %i[index show]
end
