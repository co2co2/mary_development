Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'
  resources :users, only: [:show]
  resources :strains, only: [:show, :index]
  resources :recipes do
  	resources :reviews, except: [:index, :new, :show]
  	put :favourite
  end
  get '/search', to: 'recipes#search_results'
  get '/map', to: 'strains#map'
  resources :recipe_categories, only: [:show]
  resources :allergies, only: [:show]
  resources :effects, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
