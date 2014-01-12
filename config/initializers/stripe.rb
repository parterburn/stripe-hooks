Stripe.api_key = ENV['STRIPE_KEY'] # Set your api key

StripeEvent.configure do |events|
  events.subscribe 'charge.failed' do |event|
    # Define subscriber behavior based on the event object
    event.class       #=> Stripe::Event
    event.type        #=> "charge.failed"
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
    ActionMailer::Base.mail(:from => "pleasereply@brandfolder.com", :to => "paul@brandfolder.com", :subject => "Stripe Event", :body => "Charge Failed").deliver
  end

  events.all do |event|
    # Handle all event types - logging, etc.
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