require 'test_helper'

class SelectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get selections_list_url
    assert_response :success
  end

end
