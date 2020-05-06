class AddApiKeyToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :api_key, :string
  end
end
