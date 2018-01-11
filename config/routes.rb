Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'
  resources :users, only: [:show]
  resources :recipes do
  	resources :reviews, except: [:index, :new, :show]
  	put :favourite
  end
  get '/search', to: 'recipes#search_results'
  resources :recipe_categories, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
