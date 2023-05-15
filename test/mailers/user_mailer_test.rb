require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "mail_subscription" do
    mail = UserMailer.mail_subscription
    assert_equal "Mail subscription", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
