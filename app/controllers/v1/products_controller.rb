class V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :ok
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @product, status: :ok
  end

  def update
    @product.update(product_params)
    render json: @product.reload, status: :ok
  end

  def destroy
    @product.destroy
    render status: :no_content
  end

  private

  def product_params
    params.permit(:name,
                  :manufactory,
                  :cost_price)
  end


  def set_product
    @product = Product.find(params[:id])
  end
end
