stripe-hooks
============

A simple email notification app for Stripe events.

============

In order to setup, you'll need to setup environmental variables:

```
STRIPE_KEY: sk_live_your_stripe_api_key
SENDGRID_USERNAME: your_sendgrid_username
SENDGRID_PASSWORD: your_sendgrid_password
SENDGRID_DOMAIN: domain.com
EMAIL_FROM: Billing <your@domain.com>
EMAIL_TO: email@to-send-events-to.com
```

In the [Webhooks](https://manage.stripe.com/account/webhooks) section of Stripe add the URL of your app: http://your-app.herokuapp.com/process