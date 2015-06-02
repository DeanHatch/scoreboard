# Preview all emails at http://localhost:3000/rails/mailers/customer_emailer
class CustomerEmailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/customer_emailer/welcome
  def welcome
    CustomerEmailer.welcome
  end

end
