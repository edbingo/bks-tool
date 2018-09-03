require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get hub" do
    get admin_url
    assert_response :success
  end

end
