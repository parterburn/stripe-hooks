class Notifier < ActionMailer::Base
  include SendGrid

  sendgrid_category "Stripe Events"
  sendgrid_disable  :ganalytics, :opentrack, :clicktrack

  headers['x-smtpapi'] = {
    "filters" : {
      "template" : {
        "settings" : {
          "enable" : 1,
          "text/html" : "<% body %>"
        }
      }
    }
  }.to_json

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_event_email(event)

    mail(
      :from => ENV["EMAIL_FROM"],
      :to => ENV["EMAIL_TO"],
      :subject => "[Stripe] #{event.type} for #{event.data.object.email}"
      )
  end
end