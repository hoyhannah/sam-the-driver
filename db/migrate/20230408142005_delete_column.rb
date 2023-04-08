class DeleteColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :cart_items, :unit_price
  end
end
