require 'test_helper'

class CustomerEmailerTest < ActionMailer::TestCase
  test "welcome" do
    mail = CustomerEmailer.welcome(Customer.new({ userid: "user@id.com",
					password: "yabba",
					password_confirmation: "yabba",
					name: "Fred Flintstone",
					phone: "(111) 555-1212",
					website: "www.id.com" }))
    assert_equal "Welcome", mail.subject
    assert_equal ["user@id.com"], mail.to
    assert_equal ["TheFolks@Online-Scoreboard.net"], mail.from
    #assert_match "Hi", mail.body.encoded
  end

end
