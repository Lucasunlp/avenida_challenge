class Api::V1::Orders::Index
  def call(client)
    query = client.orders
    construct(query)
  end

  private

  def construct(query)
    data = generate_response_representable(query)
    Api::V1::StandardResponse.new.call(
      status: 'ok',
      data: data
    )
  end

  def generate_response_representable(orders)
    orders.map do |order|
      ::OrderRepresenter.new(order)
    end
  end
end
