require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get hilfe" do
    get static_pages_hilfe_url
    assert_response :success
  end

end
