require 'test_helper'
# This file tests that pages really work. It also checks all links to make sure
# nothing breaks.
class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "BKS Tool"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get hilfe" do
    get hilfe_path
    assert_response :success
    assert_select "title", "Hilfe | #{@base_title}"
  end

  test "should get impressum" do
    get impressum_path
    assert_response :success
    assert_select "title", "Impressum | #{@base_title}"
  end

  test "should get kontakt" do
    get kontakt_path
    assert_response :success
    assert_select "title", "Kontakt | #{@base_title}"
  end

end
