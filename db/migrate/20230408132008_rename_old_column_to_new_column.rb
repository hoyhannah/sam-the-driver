class RenameOldColumnToNewColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :carts, :deleted, :active
  end
end
