class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.string :user
      t.boolean :deleted
      t.timestamps
    end
  end
end
