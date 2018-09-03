require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.new(Name: "Surname", Vorname: "Name", Mail: "l999@bks-campus.ch",
    Number: "l999", password: "123456", password_confirmation: "123456")
  end

  test "should be valid" do
    assert @admin.valid?
  end

  test "surName should be present" do
    @admin.Name = "     "
    assert_not @admin.valid?
  end

  test "name should be present" do
    @admin.Vorname = "     "
    assert_not @admin.valid?
  end

  test "mail should be present" do
    @admin.Mail = "     "
    assert_not @admin.valid?
  end

  test "number should be present" do
    @admin.Number = "     "
    assert_not @admin.valid?
  end

  test "password should be present" do
    @admin.password = "     "
    assert_not @admin.valid?
  end
end
