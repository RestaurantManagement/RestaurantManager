Rails.application.routes.draw do

  

  root 'static_pages#home'	
  get  '/about',   to: 'static_pages#about'
  get  '/signup',  to: 'users#new'
  #sessions 's routes
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  #additional routes for resources:
  ##categories
  get   '/menu',  to:  'categories#menu'
  get   '/menu/:id',  to: 'categories#category', as: 'category_items'
  ### menu_items
  get   '/menu_items/:id/new', to: 'menu_items#newByCategory', as: 'new_menu_item_by_category'

  #built-in resources routes
  resources :users
  resources :categories
  resources :menu_items, only: [:new, :show, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
