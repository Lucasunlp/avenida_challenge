class Product < ApplicationRecord
  has_many :purchases
  has_many :orders, through: :purchases
  belongs_to :client
  validates :title, :description, :available_stock, :price, presence: true
end
