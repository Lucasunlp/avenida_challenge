class Api::V1::Products::Index
  def call(params)
    if params[:product_id].nil?
      query = Product.all
    else
      query = Product.where(product: params[:product_id])
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

  def generate_response_representable(products)
    products.map do |product|
      ::ProductRepresenter.new(product)
    end
  end
end
