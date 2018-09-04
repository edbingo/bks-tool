require 'test_helper'

class StudMailMailerTest < ActionMailer::TestCase
  test "password_delivery" do
    mail = StudMailMailer.password_delivery
    assert_equal "Password delivery", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "pres_list" do
    mail = StudMailMailer.pres_list
    assert_equal "Pres list", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "nonactive_warning" do
    mail = StudMailMailer.nonactive_warning
    assert_equal "Nonactive warning", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
