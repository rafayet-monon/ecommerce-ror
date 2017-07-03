Rails.application.routes.draw do


  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }
  devise_for :admins, path: 'admins', controllers: {session: "admins/sessions"}
  root 'store#index'

  resources :categories do
    get :subcategory, on: :member
  end


  get '/categories/:id' , to: 'categories#subcategory_index', as: 'subcategory'

  resources :products

  resources :brands

  get '/product-by-category/:id' , to: 'store#product_by_category' , as: 'category_product'
  get '/product-details/:id' , to: 'store#product_details' ,  as: "product_details"
end
