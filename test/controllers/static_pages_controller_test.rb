require 'test_helper'
# This file tests that pages really work. It also checks all links to make sure
# nothing breaks.
class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "BKS Tool"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get hilfe" do
    get static_pages_hilfe_url
    assert_response :success
    assert_select "title", "Hilfe | #{@base_title}"
  end

  test "should get impressum" do
    get static_pages_impressum_url
    assert_response :success
    assert_select "title", "Impressum | #{@base_title}"
  end

end
