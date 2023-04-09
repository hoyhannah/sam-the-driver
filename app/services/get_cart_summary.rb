# frozen_string_literal: true

# Service for Get Cart Summary
class GetCartSummary < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    validate_params

    cart_summary = {
      cart_items: map_product_info,
      total: total
    }

    if eligible_for_discount?
      cart_summary[:discount] = discount
      cart_summary[:total] = discounted_total
    end

    cart_summary
  end

  def validate_params
    cart = Cart.find_by(id: cart_id, user_id: current_user.id)
    raise ActiveRecord::RecordNotFound.new('Cart not found for current user') if cart.nil?
  end

  def cart_items
    @cart_items ||= CartItem.where(cart_id: cart_id)
  end

  def discount_rate
    @discount_rate ||= DiscountRates::RATES.find { |range, _rate| range.cover?(total) }&.last || 0
  end

  def discounted_total
    @discounted_total ||= (total * (1 - discount_rate)).round(2)
  end

  def discount
    @discount ||= {
      rate: discount_rate,
      total_before_discount: total
    }
  end

  def total
    @total ||= (map_product_info.sum { |item| item[:price].to_f * item[:quantity] }).round(2)
  end

  def eligible_for_discount?
    total >= 20.00
  end

  def map_product_info
    @map_product_info ||= cart_items.map do |item|
      product = products.find { |p| p['uuid'] == item['item_id'] }
      {
        name: product['name'],
        price: product['price'],
        quantity: item['quantity']
      }
    end
  end

  def products
    @products ||= JSON.parse(File.read('./products.json'))
  end

  def current_user
    @current_user = params[:current_user]
  end

  def cart_id
    @cart_id = params[:cart_id]
  end
end
