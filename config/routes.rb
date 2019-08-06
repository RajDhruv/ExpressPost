Rails.application.routes.draw do
  root 'posts#home'
  resources :posts do
  	member do
  		get 'delete'
  	end
  	collection do
  		get 'home'
  		get 'my_posts'
  	end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
