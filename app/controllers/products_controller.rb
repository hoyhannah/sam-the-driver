class ProductsController < ApplicationController
  def index
    @products = GetProducts.call
    render json: @products
  end
end
