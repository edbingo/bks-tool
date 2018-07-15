require 'test_helper'

class SchuelersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get schuelers_new_url
    assert_response :success
  end

end
