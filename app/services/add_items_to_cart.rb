# frozen_string_literal: true

# Service for Add Items to Cart
class AddItemsToCart < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    add_to_cart
  end

  def add_to_cart
    @add_to_cart = CartItem.create(
      cart_id: cart.id,
      item_id: item_id,
      quantity: quantity
    )
  end

  def cart
    @cart = Cart.find_by(user_id: current_user.id, active: true)
  end

  def current_user
    @current_user = params[:current_user]
  end

  def item_id
    @item_id = params[:item_id]
  end

  def quantity
    @quantity = params[:quantity]
  end
end
