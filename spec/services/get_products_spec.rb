# frozen_string_literal: true

require 'rails_helper'

describe GetProducts do
  describe '#call' do
    let(:service) { described_class.new }

    it 'returns an array of products' do
      products = service.call

      expect(products).to be_an(Array)
      expect(products.first).to include('uuid', 'name', 'price')
    end
  end
end
