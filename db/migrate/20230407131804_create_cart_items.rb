class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.integer :cart_id, null: false
      t.integer :item_id, null: false
      t.integer :quantity
      t.integer :unit_price
      t.timestamps
    end
  end
end
