Stripe.api_key = ENV['STRIPE_KEY'] # Set your api key

StripeEvent.configure do |events|
  events.all do |event|
    subject = "[Stripe] #{event.type} for #{event.data.object.email}"
    body = "<a href='https://manage.stripe.com/search?query=#{event.data.object.id}'>#{event.data.object.email}</a> has #{event.type}"
    stripe_mailer(subject, body)
  end
end

# Subscriber objects that respond to #call

class CustomerCreated
  def call(event)
    # Event handling
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
  events.subscribe 'customer.created', CustomerCreated.new
end

# Subscribing to a namespace of event types

StripeEvent.subscribe 'customer.card.' do |event|
  # Will be triggered for any customer.card.* events
end

def stripe_mailer(subject, body)
  SMTPAPI = "{ 'filters': { 'clicktrack' : { 'settings' : { 'enable' : 0 } }, 'ganalytics' : { 'settings' : { 'enable' : 0 } }, 'template' : { 'settings' : { 'enable' : 0 } } } }"
  ActionMailer::Base.mail(
    :from => ENV["EMAIL_FROM"],
    :to => ENV["EMAIL_TO"],
    :subject => subject,
    :body => body,
    :content_type => "text/html",
    :headers['X-SMTPAPI'] => SMTPAPI
  ).deliver
end