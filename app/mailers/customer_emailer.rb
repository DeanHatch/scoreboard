class CustomerEmailer < ActionMailer::Base
  default from: "TheFolks@Online-Scoreboard.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.customer_emailer.welcome.subject
  #
  def welcome(customer)
    @greeting = "Hi"
    @customer = customer
    mail to: customer.email
  end
end
