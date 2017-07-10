class CategoriesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @categories=Category.all.where(parent_id: nil)
  end
 
  def new
    @categories=Category.all.where(parent_id: nil)
    @category = Category.new

    respond_to do |format|
      format.js {}
    end
  end

  def edit
    @category = Category.find(params[:id])
    respond_to do |format|
      format.js {}
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      # redirect_to categories_path
      respond_to do |format|
        format.js {}
      end
    end
  end

  def create
  @category= Category.new(category_params)

  @category.save

    redirect_to categories_path

  #   render plain: params[:category].inspect
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  def subcategory
    @category=Category.find(params[:id])
    @subcategories=Category.all.where(parent_id: @category.id )
  end

  def show
    @category=Category.find(params[:id])
    @subcategories=Category.all.where(parent_id: @category.id )
  end


  def category_yearly_sales

    if params[:date].present?
      @year= params[:date][:year].to_i

    else
      @year= Date.today.year

    end

    @categories =Category.all.where(parent_id: nil)
    @total_sell = Category.get_total_sell(@year)


  end

  def category_monthly_sales

    if params[:date].present?
      @year= params[:date][:year].to_i
      @month=params[:date][:month].to_i

    else
      @year= Date.today.year
      @month = Date.today.month
    end

    @days_of_month = Time.days_in_month(@month , @year)
    @categories =Category.all.where(parent_id: nil)
    @total_sell_by_month = Category.get_total_sell_by_month(@year , @month, @days_of_month)
  end

  private
  def category_params
  params.require(:category).permit!
  end

end
