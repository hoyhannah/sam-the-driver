# frozen_string_literal: true

# Service for Add Items to Cart
class AddItemsToCart < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    if cart_item
      update_cart_item

      cart_item
    else
      add_to_cart
    end
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

  def update_cart_item
    cart_item.update(quantity: quantity.to_i + cart_item.quantity.to_i)
  end

  def cart_item
    @cart_item = CartItem.find_by(cart_id: cart.id, item_id: item_id)
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
