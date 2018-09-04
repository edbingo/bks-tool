require 'test_helper'

class StudentMailerTest < ActionMailer::TestCase
  test "password_mail" do
    mail = StudentMailer.password_mail
    assert_equal "Password mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "catchup_mail" do
    mail = StudentMailer.catchup_mail
    assert_equal "Catchup mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "final_mail" do
    mail = StudentMailer.final_mail
    assert_equal "Final mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
