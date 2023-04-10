# frozen_string_literal: true

require 'rails_helper'

describe ProductsController, type: :controller do
  describe '#index' do
    let(:products) do
      [
        { id: 1, name: 'some_product_1', price: 10.0 },
        { id: 2, name: 'some_product_2', price: 20.0 }
      ]
    end

    before do
      allow(Product).to receive(:all).and_return(products)
    end

    it 'returns a JSON response with the products' do
      get :index

      expect(response.body).to eq(products.to_json)
    end
  end
end
