class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
   create_table :purchases do |t|
     t.references :order, index: true
     t.references :product, index: true
     t.timestamps
   end
  end
end
