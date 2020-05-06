require 'test_helper'
class Api::V1::ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_client = clients(:client_one)
  end

  test 'should get client  by client id ' do
    headers = {
      'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}",
      'Content-Type' => 'application/json'
    }
    # Get url
    get '/api/v1/clients/', headers: headers
    results = JSON.parse(response.body)
    assert_response :success
    # We've two clients in our db
    assert_equal 2, results['data'].size
  end

  test 'shouldnt get client by client id' do
    # Get response 200
    get '/api/v1/clients/122', headers: { 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}"}

    assert_response :success
    results = JSON.parse(response.body)
    results['data'].include? 'Not found elements'
  end

  test 'should show a client by client id' do
    # Get url
    get '/api/v1/clients/'"#{@current_client.id}", headers:{ 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}",
                    'Content-Type' => 'application/json' }
    assert_response :success
    # Check type response
    assert_equal response.content_type, 'application/json'
    results = JSON.parse(response.body)
    assert_equal @current_client.id, results['data']['id']
  end

  test 'should create a client' do
    assert_difference 'Client.count' do
      post api_v1_clients_path, params: {
        client: client_params
      }
    end
    assert_response :success
  end

  test 'should destroy a client' do
    assert_difference 'Client.count', -1 do
      delete api_v1_client_path(@current_client), headers:{ 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}"}
    end
    assert_response :success
  end

  test 'should edit a client' do
    before = @current_client.full_name
    get api_v1_client_path(@current_client), headers:{ 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}",
                    'Content-Type' => 'application/json' }
    assert_response :success
    patch api_v1_client_path, params: { client: client_params }, headers:{ 'HTTP_AUTHORIZATION' => 'Token token='"#{@current_client.api_key}" }
    @current_client.reload
    assert_not_equal before, @current_client.full_name
  end

  private

  def client_params
      {
        full_name: 'lucas albo',
        email: 'lucas@gmail.com',
        id_card: 3230,
        phone: 32323,
        address: '139'
      }
  end
end
