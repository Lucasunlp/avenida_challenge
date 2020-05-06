
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:one)
  end

  test 'title should be present' do
    @product.title = nil

    assert_not @product.valid?
  end

  test 'description should be present' do
    @product.description = nil

    assert_equal false, @product.valid?
  end
end
