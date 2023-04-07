class CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    render json: @cart_items
  end

  def show
    @cart_item = CartItem.find(params[:id])
    render json: @cart_item
  end

  def create
    @cart_item = CartItem.create(
      cart_id: params[:cart_id],
      item_id: params[:item_id],
      quantity: params[:quantity],
      unit_price: params[:unit_price]
    )
    render json: @cart_item
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(
      cart_id: params[:cart_id],
      item_id: params[:item_id],
      quantity: params[:quantity],
      unit_price: params[:unit_price]
    )
    render json: @cart_item
  end

  def destroy
    @cart_items = CartItem.all
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    render json: @cart_items
  end
end
