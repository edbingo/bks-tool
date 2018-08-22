require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.new(name: "Surname", vorname: "Name", mail: "l999@bks-campus.ch",
    number: "l999")
  end

  test "should be valid" do
    assert @admin.valid?
  end

  test "surname should be present" do
    @admin.name = "     "
    assert_not @admin.valid?
  end

  test "name should be present" do
    @admin.vorname = "     "
    assert_not @admin.valid?
  end

  test "mail should be present" do
    @admin.mail = "     "
    assert_not @admin.valid?
  end

  test "number should be present" do
    @admin.number = "     "
    assert_not @admin.valid?
  end
end
