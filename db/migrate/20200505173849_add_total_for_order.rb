class AddTotalForOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total, :decimal, default: 0
  end
end
