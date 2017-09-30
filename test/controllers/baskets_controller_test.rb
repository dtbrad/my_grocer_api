require 'test_helper'

class BasketsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get baskets_index_url
    assert_response :success
  end

end
