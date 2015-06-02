# Preview all emails at http://localhost:3000/rails/mailers/support_emailer
class SupportEmailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/support_emailer/rant
  def rant
    SupportEmailer.rant
  end

end
