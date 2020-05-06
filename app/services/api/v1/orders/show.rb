class Api::V1::Orders::Show
  def call(client, id)
    query = id.nil? ? nil : client.orders.where(id: id)
    construct(query)
  end

  private

  def construct(query)
    data = generate_response_representable(query.first) unless query.nil?
    Api::V1::StandardResponse.new.call(
      status: 'ok',
      data: data
    )
  end

  def generate_response_representable(order)
    OrderRepresenter.new(order)
  end
end
