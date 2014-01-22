Stripe.api_key = ENV['STRIPE_KEY'] # Set your api key

StripeEvent.configure do |events|
  events.all do |event|
    Notifier.send_event_email(event).deliver
  end
end