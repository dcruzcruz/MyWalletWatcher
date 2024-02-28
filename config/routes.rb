Rails.application.routes.draw do
  root 'home#index'

  resources :accounts
  #resources :transactions
  resources :household_members

  resources :categories
  resources :tags

  resources :transactions do
    resources :transaction_categories, only: [:index, :new, :create]
    resources :transaction_tags, only: [:index, :new, :create]
  end

  resources :household_members do
    resources :accounts do
      resources :transactions, only: [:index, :new, :create]
    end
  end

  # Other routes...

  # Example of a non-resourceful route
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
end
