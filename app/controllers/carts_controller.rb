# frozen_string_literal: true

# Carts Controller
class CartsController < ApplicationController
  include Authenticable

  def index
    @carts = Cart.all
    render json: @carts
  end

  def summary
    @cart = GetCartSummary.call(
      cart_id: params[:id],
      current_user: @current_user
    )
    render json: @cart
  end

  def current
    @cart = GetCartCurrent.call(
      current_user: @current_user
    )
    render json: @cart
  end

  def show
    @cart = Cart.find(params[:id])
    render json: @cart
  end

  def create
    @cart = Cart.create(
      user_id: params[:user_id],
      active: true
    )
    render json: @cart
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(
      user_id: params[:user_id],
      active: params[:active]
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
