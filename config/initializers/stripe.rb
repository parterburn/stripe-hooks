Stripe.api_key = ENV['STRIPE_KEY'] # Set your api key

class EmailEvent
  def call(event)
    Notifier.send_event_email(event).deliver
  end
end

class EmailJson
  def call(event)
    Notifier.send_json(event).deliver
  end
end

StripeEvent.configure do |events|
  events.subscribe 'customer.', EmailEvent.new
  events.subscribe 'invoice.',  EmailEvent.new
  events.subscribe 'transfer.', EmailJson.new
  events.subscribe 'plan.',     EmailJson.new
  events.subscribe 'coupon.',   EmailJson.new
  events.subscribe 'charge.',   EmailJson.new
  events.subscribe 'account.',  EmailJson.new
end