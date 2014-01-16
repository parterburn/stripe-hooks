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
        },

        :ganalytics => {
          :settings => {
            :enable => 0
          }
        }

      }
    }.to_json

    if event.data.object.email
      subject_cust = event.data.object.email
    else
      subject_cust = event.data.object.customer
    end

    mail(
      :from => ENV["EMAIL_FROM"],
      :to => ENV["EMAIL_TO"],
      :subject => "[Stripe] #{event.type} for #{subject_cust}"
      )
  end
end