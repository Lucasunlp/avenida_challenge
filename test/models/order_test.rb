require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:one)
  end

  test 'valid client reference' do
    assert_equal true, @order.client.present?
  end

  test 'invalid client reference' do
    order = orders(:three)
    assert_not_equal true, order.client.present?
  end
end
