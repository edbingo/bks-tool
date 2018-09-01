require 'test_helper'

class PresentationsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get presentations_list_url
    assert_response :success
  end

end
