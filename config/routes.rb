Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'
  resources :recipes do
  	resources :reviews, except: [:index, :new, :show]
  	put :favourite
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
