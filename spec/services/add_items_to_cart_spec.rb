# frozen_string_literal: true

require 'rails_helper'

describe AddItemsToCart do
  let(:user) { FactoryBot.create(:user_entity) }
  let(:service) { described_class.new(params) }

  describe '#call' do
    context 'when has a exisiting product and cart' do
      let(:product) { FactoryBot.create(:product_entity) }
      let(:params) { { current_user: user, item_id: product.id, quantity: 1 } }
      let!(:cart) { FactoryBot.create(:cart_entity, user_id: user.id, active: true) }

      context 'when the cart item already exists' do
        let!(:cart_item) { FactoryBot.create(:cart_item_entity, cart_id: cart.id, item_id: product.id, quantity: 1) }

        it 'updates the cart item and returns it' do
          expect(service.call).to eq(cart_item.reload)
          expect(cart_item.quantity).to eq(2)
        end
      end

      context 'when the cart item does not exist' do
        it 'creates a new cart item and returns it' do
          expect { service.call }.to change(CartItem, :count).by(1)

          new_cart_item = CartItem.last
          expect(new_cart_item.cart_id).to eq(cart.id)
          expect(new_cart_item.item_id).to eq(product.id)
          expect(new_cart_item.quantity).to eq(1)
          expect(service.call).to eq(new_cart_item)
        end
      end
    end

    context 'when the cart is not found for the current user' do
      let(:product) { FactoryBot.create(:product_entity) }
      let(:params) { { current_user: user, item_id: product.id, quantity: 1 } }
      it 'raises a RecordNotFound error' do
        expect { service.call }.to raise_error(RecordNotFound, 'Cart not found for current user')
      end
    end

    context 'when the product does not exist' do
      let(:params) { { current_user: user, item_id: 'some_id', quantity: 1 } }
      let!(:cart) { FactoryBot.create(:cart_entity, user_id: user.id, active: true) }
      it 'raises a RecordNotFound error' do
        expect { service.call }.to raise_error(RecordNotFound, 'Product not exisiting')
      end
    end
  end
end
