require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get anmeldung_path
    assert_response :success
  end

end
