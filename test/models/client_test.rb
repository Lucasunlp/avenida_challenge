require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  def setup
    @client = clients(:client_one)
  end

  test 'client shouldnt be valid' do
    @client.id = nil

    assert_equal false, @client.valid?
  end

  test 'email should be present' do
    @client.email = nil

    assert_not @client.valid?
  end

  test 'should have numeric phone' do
    @client.phone = 'asd'

    assert_equal false, @client.valid?
  end

  test 'full_name should be present' do
    @client.full_name = nil

    assert_equal false, @client.valid?
  end

  test 'id_card should be present' do
    @client.id_card = nil

    assert_equal false, @client.valid?
  end

  test 'phone should be present' do
    @client.phone = nil

    assert_not @client.valid?
  end

  test 'address should be present' do
    @client.address = nil

    assert_not @client.valid?
  end

  test 'email should be valid' do
    # ADD REGEX TO VALIDATE EMAIL
    # @client.email = 'lucas@gmail.com'
    #
    # assert_not @client.valid?
  end
end
