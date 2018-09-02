require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get hub" do
    get admins_hub_url
    assert_response :success
  end

end
