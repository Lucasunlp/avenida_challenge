require 'test_helper'
class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_client =  clients(:client_one)
    @current_product = products(:one)
  end

  test 'should get product  by product id ' do
    headers = {
      'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}",
      'Content-Type' => 'application/json'
    }
    # Recognize url
    assert_equal true, assert_recognizes({ controller: 'api/v1/products', action: 'index' },{:path => '/api/v1/products', :method => :get})
    # Get url
    get '/api/v1/products/', headers: headers
    results = JSON.parse(response.body)
    assert_response :success
    # We've two products in our db
    assert_equal 2, results['data'].size
  end

  test 'shouldnt get product by product id' do
    headers = { 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}",
                'Content-Type' => 'application/json' }
    # Get response 200
    get '/api/v1/products/122', headers: headers

    assert_response :success
    results = JSON.parse(response.body)
    results['data'].include? 'Not found elements'
  end

  test 'should show a product by product id' do
    headers = { 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}",
                'Content-Type' => 'application/json' }
    # Get url
    get '/api/v1/products/'"#{@current_product.id}", headers: headers
    assert_response :success
    # Check type response
    assert_equal response.content_type, 'application/json'
    results = JSON.parse(response.body)
    assert_equal @current_product.id, results['data']['id']
  end

  test 'should create a product' do
    assert_difference 'Product.count' do
      post api_v1_products_path, params: {
        product: product_params
      }, headers: { 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}"}
    end
    assert_response :success
  end

  test 'should destroy a product' do
    assert_difference 'Product.count', -1 do
      delete api_v1_product_path(@current_product), headers:{ 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}",
                      'Content-Type' => 'application/json' }

    end
    assert_response :success
  end

  test 'should edit a product' do
    before = @current_product.title
    get api_v1_product_path(@current_product), headers:{ 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}"}
    assert_response :success
    patch api_v1_product_path, params: { product: product_params }, headers:{ 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}" }
    @current_product.reload
    assert_not_equal before, @current_product.title
  end

  private

  def product_params
    {
      title: 'Iphone 7',
      description: '128 GB',
      available_stock: 100,
      price: 32323,
      visible: true
    }
  end
end
