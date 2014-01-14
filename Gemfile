source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'puma', '~> 2.0.1' # web server
gem 'slim', '~> 2.0.0' # Templating for queue
gem 'jquery-rails'
gem 'stripe_event'

# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'heroku-deflater', '~> 0.5.1' # Deflate assets in production
end