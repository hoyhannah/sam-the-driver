class CartsController < ApplicationController
  def index
    @carts = Cart.all
    render json: @carts
  end

  def show
    @cart = Cart.find(params[:id])
    render json: @cart
  end

  def create
    @cart = Cart.create(
      user: params[:user],
      deleted: false
    )
    render json: @cart
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(
      user: params[:user],
      deleted: params[:deleted]
    )
    render json: @cart
  end

  def destroy
    @carts = Cart.all
    @cart = Cart.find(params[:id])
    @cart.destroy
    render json: @carts
  end
end
