require 'test_helper'

class SupportEmailerTest < ActionMailer::TestCase
  test "rant" do
    mail = SupportEmailer.rant([])
    assert_equal "Rant", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
