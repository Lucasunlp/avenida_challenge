require 'representable/json'

class OrderRepresenter < Representable::Decorator
  include Representable::JSON
  property :id
  property :created_at

  nested :client, as: :client do
    property :full_name_client
    property :email_client
  end

  nested :purchases, as: :purchases_list do
    property :title_purchase
    property :price_purchase
    property :description_purchase
  end
end
