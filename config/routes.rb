Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'
  resources :users, only: [:show]
  resources :strains, only: [:show, :index]
  resources :recipes do
  	resources :reviews, except: [:index, :new, :show]
    # change to patch later
    put '/rate', to: 'recipes#rate'
  	put :favourite
  end
  # get '/404', to: 'application#not_found'
  get '/filter', to: 'recipes#filter'
  get '/search', to: 'recipes#search_results'

  get '/search_dispensaries', to: 'strains#search_dispensaries'
  get '/dispensaries', to: 'strains#dispensaries'
  get '/cod_to_address', to: 'strains#cod_to_address'
  resources :recipe_categories, only: [:show]
  resources :allergies, only: [:show]
  resources :effects, only: [:show]
# static pages route
  get "/pages/:page" => "pages#show"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
