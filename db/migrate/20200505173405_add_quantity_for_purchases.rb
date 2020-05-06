class AddQuantityForPurchases < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :quantity, :integer, default: 0
  end
end
