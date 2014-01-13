class Notifier < ActionMailer::Base

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_event_email(event)
    @event = event
    headers['x-smtpapi'] = {
      :filters => {
        
        :template => {
          :settings => {
            :enable => 1,
            :"text/html" => "<% body %>"
          }
        },

        :clicktrack => {
          :settings => {
            :enable => 0
          }
        },

        :opentrack => {
          :settings => {
            :enable => 0
          }
        },

        :subscriptiontrack => {
          :settings => {
            :enable => 0
          }
        }

      }
    }.to_json

    mail(
      :from => ENV["EMAIL_FROM"],
      :to => ENV["EMAIL_TO"],
      :subject => "[Stripe] #{event.type} for #{event.data.object.email}"
      )
  end
end