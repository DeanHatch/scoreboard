class CustomerEmailer < ActionMailer::Base
  default from: "TheFolks@Online-Scoreboard.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.customer_emailer.welcome.subject
  #
  def welcome(recipient)
    @greeting = "Hi"

    #mail to: "to@example.org"
    mail to: recipient
  end
end
