require 'test_helper'
class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_order = orders(:one)
    @current_client = clients(:client_one)
    @current_product = products(:two)
  end

  test 'should get order by order id ' do
    headers = {'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}" }
    # Get url
    get '/api/v1/orders/'"#{@current_order.id}", headers: headers
    results = JSON.parse(response.body)
    # We've two orders in our db
    assert_equal true, results.present?
  end

  test 'shouldnt get order by order id' do
    headers = { 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}", 'Content-Type' => 'application/json' }
    get '/api/v1/orders/122', headers: headers

    results = JSON.parse(response.body)
    results["notifications"].include? 'Order doesnt exist!'
  end

  test 'should show a order by order id' do
    headers = { 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}"}
    # Get url
    get '/api/v1/orders/'"#{@current_client.orders.first.id}", headers: headers
    # Check type response
    assert_equal response.content_type, 'application/json'
  end

  test 'should destroy a order' do
    assert_difference '@current_client.orders.count',-1 do
      delete api_v1_order_path(@current_order.id), headers: { 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}" }
    end
    assert_response :success
  end

  test 'should create a order' do
    assert_difference '@current_client.orders.count', 0 do
      order_params = { "product_ids_and_quantities" => [[@current_product.id, 2]] }
      post api_v1_orders_path(order_params), params: {order: order_params }, as: :json, headers: { 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}"  }
    end
    assert_response :success
  end

end
