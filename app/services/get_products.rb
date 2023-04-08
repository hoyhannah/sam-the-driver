# frozen_string_literal: true

# ProductService
class GetProducts < ApplicationService
  def call
    file = File.read('./products.json')

    JSON.parse(file)
  end
end
