require 'test_helper'

class TeachersControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get teachers_list_url
    assert_response :success
  end

end
