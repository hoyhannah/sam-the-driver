# frozen_string_literal: true

# Service for Get Cart Current
class GetCartCurrent < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    cart || new_cart
  end

  def cart
    @cart = Cart.find_by(user_id: current_user.id, active: true)
  end

  def new_cart
    @new_cart = Cart.create(
      user_id: current_user.id,
      active: true
    )
  end

  def current_user
    @current_user = params[:current_user]
  end
end
