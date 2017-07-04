class StoreController < ApplicationController

  # before_action :authenticate_admin!

  def index
    @products=Product.all
    @categories=Category.all.where(parent_id: nil)
    @cart=current_cart
  end

  def product_by_category
    @categories=Category.all.where(parent_id: nil)
    @product_by_category=Category.includes(:products).find(params[:id])
  end

  def product_details
    @product=Product.includes(:brand, :category, :subcategory).find(params[:id])
  end

end
