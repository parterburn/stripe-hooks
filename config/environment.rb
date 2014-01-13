# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
StripeHooks::Application.initialize!

#SendGrid Mailer
ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :user_name => ENV["SENDGRID_USERNAME"],
  :password => ENV["SENDGRID_PASSWORD"],
  :domain => ENV["SENDGRID_DOMAIN"],
  :enable_starttls_auto => true
}