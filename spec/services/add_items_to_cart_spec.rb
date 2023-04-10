# frozen_string_literal: true

require 'rails_helper'

describe AddItemsToCart do
  let(:user) { FactoryBot.create(:user_entity) }
  let(:item_id) { 1 }
  let(:params) { { current_user: user, item_id: item_id, quantity: 1 } }
  let(:service) { described_class.new(params) }

  describe '#call' do
    context 'when the cart item already exists' do
      let!(:cart_item) { FactoryBot.create(:cart_item_entity, cart_id: cart.id, item_id: item_id, quantity: 1) }
      let!(:cart) { FactoryBot.create(:cart_entity, user_id: user.id, active: true) }

      it 'updates the cart item and returns it' do
        expect(service.call).to eq(cart_item.reload)
        expect(cart_item.quantity).to eq(2)
      end
    end

    context 'when the cart item does not exist' do
      let!(:cart) { FactoryBot.create(:cart_entity, user_id: user.id, active: true) }

      it 'creates a new cart item and returns it' do
        expect { service.call }.to change(CartItem, :count).by(1)

        new_cart_item = CartItem.last
        expect(new_cart_item.cart_id).to eq(cart.id)
        expect(new_cart_item.item_id).to eq(item_id)
        expect(new_cart_item.quantity).to eq(1)
        expect(service.call).to eq(new_cart_item)
      end
    end
  end
end
