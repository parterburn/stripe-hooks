Stripe.api_key = ENV['STRIPE_KEY'] # Set your api key

StripeEvent.configure do |events|
  events.all do |event|
    Notifier.send_event_email(event).deliver
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