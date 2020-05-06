class AddUserToProduct < ActiveRecord::Migration[5.0]
  def change
    add_index :products, :user_id
  end
end
