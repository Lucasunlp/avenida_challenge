class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.text :title
      t.string :description
      t.integer :available_stock
      t.float :price
      t.boolean :visible

      t.timestamps
    end
  end
end
