# Preview all emails at http://localhost:3000/rails/mailers/Organization_emailer
class OrganizationEmailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/Organization_emailer/welcome
  def welcome
    OrganizationEmailer.welcome(Organization.new())
  end

end
