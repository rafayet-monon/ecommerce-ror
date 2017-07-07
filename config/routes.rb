Rails.application.routes.draw do



  resources :orders
  resources :line_items
  resources :carts


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

  get '/report/product-yearly-sales', to: 'products#product_yearly_sales' , as: 'yearly_products_sales'
  get '/report/product-monthly-sales', to: 'products#product_monthly_sales' , as: 'monthly_products_sales'
  get '/report/category-yearly-sales', to: 'categories#category_yearly_sales' , as:'category_yearly_sales'
  get '/report/category-monthly-sales', to: 'categories#category_monthly_sales' , as:'category_monthly_sales'

end
