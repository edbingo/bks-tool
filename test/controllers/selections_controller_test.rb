require 'test_helper'

class SelectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get studenten_waehlen_url
    assert_response :success
  end

end
