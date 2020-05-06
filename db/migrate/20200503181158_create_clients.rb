class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :email
      t.text :full_name
      t.integer :id_card
      t.integer :phone
      t.string :address

      t.timestamps
    end
  end
end
