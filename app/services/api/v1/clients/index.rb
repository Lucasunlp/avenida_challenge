class Api::V1::Clients::Index
  def call(params)
    if params[:client_id].nil?
      query = Client.all
    else
      query = Client.where(client: params[:client_id])
    end
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

  def generate_response_representable(clients)
    clients.map do |client|
      ::ClientRepresenter.new(client)
    end
  end
end
