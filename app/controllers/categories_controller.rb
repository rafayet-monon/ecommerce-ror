class CategoriesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @categories=Category.all.where(parent_id: nil)
  end
 
  def new
    @categories=Category.all.where(parent_id: nil)
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
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

  private
  def category_params
  params.require(:category).permit!
  end

end
