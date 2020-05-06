class OrderValidator < ActiveModel::Validator
  def validate(record)
    record.purchases.each do |purchase|
      product = purchase.product
      record.errors[product.title.to_s] << "Product is not available" unless product.visible
      if purchase.quantity > product.available_stock
        record.errors[product.title.to_s] << "Is out of stock, just #{product.available_stock} left"
      end
    end
  end
end
