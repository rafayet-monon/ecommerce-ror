class ProductsController < ApplicationController

  before_action :authenticate_admin!


  def index
    @products = Product.all.includes(:brand, :category, :subcategory )
  end

  def new
    @product =Product.new
    @categories=Category.all.where(parent_id: nil)
    @brand=Brand.all

    respond_to do |format|
      format.js
      format.html
    end


  end

  def create
    @product=Product.new(product_params)
    @product.save

    redirect_to products_path
  end

  def edit
    @product= Product.find(params[:id])
    @brand=Brand.all
    @categories=Category.all.where(parent_id: nil)
    @subcategory=@product.category.subcategories

    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @product=Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path
    end
  end

  def show
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  def product_yearly_sales

    if params[:date].present?
      @year= params[:date][:year].to_i


    else
      @year= Date.today.year


    end

    @products = Product.all
    @total_sell = Product.get_total_sell(@year)

  end

  def product_monthly_sales

    if params[:date].present?
      @year= params[:date][:year].to_i
      @month=params[:date][:month].to_i

      @days_of_month = Time.days_in_month(@month , @year)

    else
      @year= Date.today.year
      @month = Date.today.month

      @days_of_month = Time.days_in_month(@month , @year)
    end

    @products = Product.all
    @total_sell_by_month = Product.get_total_sell_by_month(@year , @month, @days_of_month)

  end


  private
  def product_params
    params.require(:product).permit!
  end
end
