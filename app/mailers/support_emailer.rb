class SupportEmailer < ActionMailer  # ::Base
  default from: "support@online-scoreboard.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_emailer.rant.subject
  #
  def rant(paramhash)
    @paramhash = paramhash
    logger.info "Param Hash is: "+paramhash.inspect()
    @greeting = "Hi"
    logger.info "Sending Mail to: "+paramhash["fromaddr"]
    mail to: paramhash["fromaddr"]
  end
end
