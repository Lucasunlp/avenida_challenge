require 'representable/json'

class ProductRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :title
  property :price
  property :description
  property :available_stock
  property :price
  property :visible
end
