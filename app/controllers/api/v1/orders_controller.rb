class Api::V1::OrdersController < ApiController
  before_action :authenticate
  before_action :find_order, only: %i[update destroy]

  # GET /api/v1/orders
  def index
    response_formater Api::V1::Orders::Index.new.call(@current_user)
  end

  # POST /api/v1/orders
  def create
    @order = @current_user.orders.build
    @order.build_orders_with_product_ids_and_quantities(params[:order][:product_ids_and_quantities])
    @order.save ? (render json: 'Your purchase was successful!', status: 200) : (render json: @order.errors.messages, status: 200)
  rescue StandardError
    error_response('Product doesnt exist!')
  end

  # PATCH /api/v1/orders/1
  def update
    @order = @current_user.orders.where(id: params[:id]).first
    render json: 'Order Edited!', status: :ok if @order.save
  end

  # GET /api/v1/orders/1
  def show
    response_formater Api::V1::Orders::Show.new.call(@current_user, params[:id])
  rescue StandardError
    error_response('Order doesnt exist!')
  end

  # DELETE /api/v1/orders/1
  def destroy
    order = @current_user.orders.where(id: params[:id]).first
    head 200 if order.destroy
  end

  private

  def order_params
    params.require(:order).permit(:quantity, product_ids_and_quantities: [])
  end

  def error_response(errors)
    render status: 404, json: {
      status: 'error',
      notifications: errors
    }.to_json
  end

  def find_order
    @order = Order.find(params[:id])
  rescue StandardError
    error_response('Order doesnt exist!')
  end
end
