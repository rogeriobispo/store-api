class V1::StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]
  def create
    store = Store.new(store_params)
    if store.save
      render json: store, status: :ok
    else
      render json: store.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @store, status: :ok
  end

  def update
    @store.update(store_params)
    render json: @store.reload, status: :ok
  end

  def destroy
    @store.destroy
    render status: :no_content
  end

  private

  def store_params
    params.permit(:name,
                  :address)
  end

  def set_store
    @store = Store.find(params[:id])
  end
end
