require 'representable/json'

class ClientRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :full_name
  property :email
  property :phone
  property :address
end
