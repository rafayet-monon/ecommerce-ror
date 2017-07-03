class BrandsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @brands= Brand.all
  end

  def new
    @brand=Brand.new
  end

  def create
    @brand =Brand.new(brand_params)
    @brand.save

    redirect_to brands_path
  end

  def edit
    @brand=Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      redirect_to brands_path
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy

    redirect_to brands_path
  end

  private
  def brand_params
    params.require(:brand).permit!
  end
end
