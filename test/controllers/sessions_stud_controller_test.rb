require 'test_helper'

class SessionsStudControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sessions_stud_new_url
    assert_response :success
  end

end
