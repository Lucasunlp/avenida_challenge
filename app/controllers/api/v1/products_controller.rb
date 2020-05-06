class Api::V1::ProductsController < ApiController
  before_action :authenticate
  before_action :find_product, only: %i[update destroy]

  # GET /api/v1/products
  def index
    response_formater Api::V1::Products::Index.new.call(params)
  end

  # POST /api/v1/products
  def create
    product = Product.new(product_params)
    render json: product, status: :created if product.save
  rescue StandardError
    error_response('Something went wrong!')
  end

  # PATCH /api/v1/products/1
  def update
    render json: @product, status: :ok if @product.update_attributes(product_params)
  end

  # GET /api/v1/products/1
  def show
    response_formater Api::V1::Products::Show.new.call(params[:id])
  end

  # DELETE /api/v1/products/1
  def destroy
    @product.destroy
    head 200
  end

  private

  def product_params
    params.require(:product).permit(:id, :title, :description, :available_stock,
                                    :price, :visible)
  end

  def error_response(errors)
    render status: 404, json: {
      status: 'error',
      notifications: errors
    }.to_json
  end

  def find_product
    @product = Product.find(params[:id])
  rescue StandardError
    error_response('Product doesnt exist!')
  end
end
