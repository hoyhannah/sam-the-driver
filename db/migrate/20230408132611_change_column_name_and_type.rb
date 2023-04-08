class ChangeColumnNameAndType < ActiveRecord::Migration[6.0]
  def change
    change_column :carts, :user, :integer
    rename_column :carts, :user, :user_id
  end
end
