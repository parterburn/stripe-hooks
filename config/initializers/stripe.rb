Stripe.api_key = ENV['STRIPE_KEY'] # Set your api key

StripeEvent.configure do |events|
  events.all do |event|
    subject = "[Stripe] #{event.type} for #{event.data.object.email}"
    body = "<a href='https://manage.stripe.com/search?query=#{event.data.object.id}'>#{event.data.object.email}</a> has #{event.type}<br><br>#{debug event.data.object}"
    stripe_mailer(subject, body)
  end
end

class BillingEventLogger
  def initialize(logger = nil)
    @logger = logger || begin
      require 'logger'
      Logger.new($stdout)
    end
  end

  def call(event)
    @logger.info "BILLING-EVENT: #{event.type} #{event.id}"
  end
end

StripeEvent.configure do |events|
  events.all BillingEventLogger.new(Rails.logger)
end

def stripe_mailer(subject, body)
  smtpapi =  { :category => { "Stripe Billing" }, :filters => { :clicktrack => { :settings => { :enable => 0 } }, :ganalytics => { :settings => { :enable => 0 } }, :template => { :settings => { :enable => 0 } } } }
  ActionMailer::Base.mail(
    :headers['X-SMTPAPI'] => smtpapi.to_json,
    :from => ENV["EMAIL_FROM"],
    :to => ENV["EMAIL_TO"],
    :subject => subject,
    :body => body,
    :content_type => "text/html",
  ).deliver
end