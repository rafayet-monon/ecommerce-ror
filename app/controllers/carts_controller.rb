class CartsController < ApplicationController

  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def index

  end

  def new
  end

  def create
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
