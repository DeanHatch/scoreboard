class ShareLinksEmailer < ActionMailer::Base
  default from: "TheFolks@Online-Scoreboard.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.customer_emailer.welcome.subject
  #
  def share_link(recipient, type, url)
    @recipient = recipient
    @type = type
    @url = url
    @greeting = "Hi"
    mail to: recipient
  end
  #
  def share_manager_link(competition, recipient, url)
    @competition = competition
    @recipient = recipient
    @type = "Manager"
    @url = url
    @greeting = "Hi"
    mail to: recipient
  end
  #
  def share_scorer_link(competition, recipient, url)
    @competition = competition
    @recipient = recipient
    @type = "Scorer"
    @url = url
    @greeting = "Hi"
    mail to: recipient
  end
  #
  def share_fan_view_link(competition, recipient, url)
    @competition = competition
    @recipient = recipient
    @type = "Fan"
    @url = url
    @greeting = "Hi"
    mail to: recipient
  end
end
