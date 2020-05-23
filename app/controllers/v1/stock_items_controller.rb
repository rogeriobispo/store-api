class  V1::StockItemsController < ApplicationController
  before_action :set_stock_item, only: [:update, :destroy]

  def create
    stock_item = StockItem.new(stock_item_params)
    if(stock_item.save)
      render json: stock_item, status: :ok
    else
      render json: stock_item.errors, status: :unprocessable_entity
    end
  end

  def update
    stock_item = StockItemIncreseQuantity.execute(@stock_item.try(:id), stock_item_quantity)
    render json: stock_item, status: :ok
  end

  def destroy
    stock_item = StockItemDecreaseQuantity.execute(@stock_item.try(:id), stock_item_quantity)
    render json: stock_item, status: :ok
  end

  private

  def stock_item_params
    params.permit(:product_id,
                  :store_id,
                  :quantity)
  end

  def set_stock_item
    @stock_item = StockItem.where(
        product_id: product_id,
        store_id: store_id).last
  end

  def product_id
    stock_item_params['product_id']
  end

  def store_id
    stock_item_params['store_id']
  end

  def stock_item_quantity
    stock_item_params[:quantity]
  end
end