class Order < ApplicationRecord
  belongs_to :client
  has_many :purchases
  # has_and_belongs_to_many :products

  validates :client_id, presence: true
  validates_with OrderValidator
  before_validation :set_total!


  # To show the nested of Representer
  def full_name_client
    client.full_name unless client.id.nil?
  end

  # To show the nested of Representer
  def email_client
    client.email unless client.id.nil?
  end

  def title_purchase
    Product.where(id: purchases.pluck(:product_id)).first.title
  end

  def price_purchase
    Product.where(id: purchases.pluck(:product_id)).first.price
  end

  def description_purchase
    Product.where(id: purchases.pluck(:product_id)).first.description
  end

  def set_total!
    self.total = 0
    purchases.each do |purchase|
      self.total += purchase.product.price * purchase.quantity
    end
  end

  def build_orders_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity
      purchases.build(product_id: id, quantity: quantity)
    end
  end
end
