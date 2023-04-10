# frozen_string_literal: true

require 'rails_helper'

describe GetCartCurrent do
  describe '#call' do
    let(:user) { FactoryBot.create(:user_entity) }
    let(:params) { { current_user: user } }
    let(:service) { described_class.new(params) }

    context 'when an active cart exists for the user' do
      let!(:cart) { FactoryBot.create(:cart_entity, user_id: user.id, active: true) }

      it 'returns the active cart' do
        expect(service.call).to eq(cart)
      end
    end

    context 'when no active cart exists for the user' do
      it 'creates a new cart and returns it' do
        expect { service.call }.to change(Cart, :count).by(1)

        new_cart = Cart.last
        expect(new_cart.user).to eq(user)
        expect(new_cart.active).to be_truthy
        expect(service.call).to eq(new_cart)
      end
    end
  end
end
