Rails.application.routes.draw do

  resources :reviews
  get 'info_staffs/new'

  get 'staffs/new'

  root 'static_pages#home'	
  get  '/about',   to: 'static_pages#about'
  get  '/signup',  to: 'users#new'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  #sessions 's routes
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  #additional routes for resources:
  ##categories
  get   '/menu',  to:  'categories#menu'
  get   '/menu/:id',  to: 'categories#category', as: 'category_items'
  ## menu_items
  get   '/menu_items/:id/new', to: 'menu_items#newByCategory', as: 'new_menu_item_by_category'
  ##temp_order
  get   '/users/:id/temp_order', to: 'temp_orders#newByUser', as: 'new_temp_order_by_user'
  delete   '/temp_orders/:id/clear', to: 'temp_orders#clear', as: 'clear_temp_order'
  ##temp_order_item
  delete   '/temp_order_items/:id', to: 'temp_order_items#destroy', as: 'destroy_temp_order_item'
  post    '/temp_order_items', to: 'temp_order_items#create', as: 'create_order_item'
  ##order
  get   '/users/:id/orders', to: 'orders#submittedOrder', as: 'submittedOrders'
  get   '/users/:uid/orders/:id', to: 'orders#detail_order', as: 'detailOrder'
  post  '/orders/:id/pay', to: 'orders#pay', as: 'payOrder'
  get   '/tables/:id/orders', to: 'orders#tableOrders', as: 'tableOrders'
  #built-in resource routes



  get   '/info_staffs/:id/new', to: 'info_staffs#newByStaff', as: 'new_info_staff_by_staff'
  get   '/list', to: 'staffs#list' 
  get   '/list/:id' , to:'staffs#staff' ,as: 'staff_items' 
  #get   'list/:id' ,to: 


  #built-in resources routes

  resources :users
  resources :categories
  resources :menu_items, only: [:new, :show, :create, :edit, :update, :destroy]
  resources :temp_orders, except: :new 
  resources :orders, except: :new
  resources :tables
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :staffs
  resources :info_staffs,only: [:new,:show,:create,:edit,:update,:destroy]
end
