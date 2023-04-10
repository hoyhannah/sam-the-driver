# frozen_string_literal: true

require 'rails_helper'

describe GetCartSummary do
  let(:user) { FactoryBot.create(:user_entity) }
  let!(:cart) { FactoryBot.create(:cart_entity, user_id: user.id, active: true) }
  let(:params) { { current_user: user, cart_id: cart.id } }

  let(:products) do
    [
      FactoryBot.create(:product_entity, id: 1, price: 5.0),
      FactoryBot.create(:product_entity, id: 2, price: 10.0)
    ]
  end

  let!(:cart_items) do
    [
      FactoryBot.create(:cart_item_entity, cart_id: cart.id, item_id: products[0].id, quantity: 1),
      FactoryBot.create(:cart_item_entity, cart_id: cart.id, item_id: products[1].id, quantity: 1)
    ]
  end

  context 'when cart is valid and has items' do
    it 'returns a hash with cart summary' do
      summary = GetCartSummary.new(params).call

      expect(summary).to include(
        cart_items: [
          { name: products[0].name, price: products[0].price, quantity: 1 },
          { name: products[1].name, price: products[1].price, quantity: 1 }
        ],
        total: 15.0
      )
    end

    context 'when cart total is eligible for a discount' do
      let!(:cart_items) do
        [
          FactoryBot.create(:cart_item_entity, cart_id: cart.id, item_id: products[0].id, quantity: 2),
          FactoryBot.create(:cart_item_entity, cart_id: cart.id, item_id: products[1].id, quantity: 2)
        ]
      end

      it 'returns a hash with cart summary and discount applied' do
        summary = GetCartSummary.new(params).call
        expect(summary).to include(
          cart_items: [
            { name: products[0].name, price: products[0].price, quantity: 2 },
            { name: products[1].name, price: products[1].price, quantity: 2 }
          ],
          total: 27.0,
          discount: { rate: 0.1, total_before_discount: 30.0 }
        )
      end
    end
  end

  context 'when cart does not exist' do
    let(:params) { { current_user: user, cart_id: 0 } }

    it 'raises a RecordNotFound error' do
      expect { described_class.call(params) }.to raise_error(RecordNotFound, 'Cart not found for current user')
    end
  end

  context 'when a cart item references a non-existing product' do
    let(:params) { { current_user: user, cart_id: cart.id } }

    before do
      create(:cart_item_entity, cart: cart, item_id: 0)
    end

    it 'raises an error when mapping product info' do
      expect { described_class.call(params) }
        .to raise_error(RecordNotFound, 'Item 0 is not found.')
    end
  end
end
