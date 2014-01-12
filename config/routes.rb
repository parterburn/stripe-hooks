StripeHooks::Application.routes.draw do
  root :to => 'landing_pages#index'

  mount StripeEvent::Engine => '/process' # provide a custom path
end
