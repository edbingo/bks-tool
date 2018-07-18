require 'test_helper'

class SchuelerTest < ActiveSupport::TestCase

  # Tests that entries in the Schueler db are correct, with all values.

  def setup
    @schueler = Schueler.new(name: "Surname", vorname: "Name", klasse: "5Gf",
      mail:"surname.name@bks-campus.ch")
  end

  # Makes sure entries are valid.

  test "should be vaild" do
    assert @schueler.valid?
  end

  test "surname should be present" do
    @schueler.name = "     "
    assert_not @schueler.valid?
  end

  test "vorname should be present" do
    @schueler.vorname = "     "
    assert_not @schueler.valid?
  end

  test "klasse should be valid" do
    @schueler.klasse = "     "
    assert_not @schueler.valid?
  end

  test "mail should be valid" do
    @schueler.mail = "     "
    assert_not @schueler.valid?
  end

  test "mail should be unique" do
    duplicate_user = @schueler.dup
    duplicate_user.mail = @schueler.mail.upcase
    @schueler.save
    assert_not duplicate_user.valid?
  end

  test "mail should be saved lowercase" do
    mixed_case_mail = "SuRnAmE.nAmE@bKs-CaMpUs.Ch"
    @schueler.mail = mixed_case_mail
    @schueler.save
    assert_equal mixed_case_mail.downcase, @schueler.reload.mail
  end

end
