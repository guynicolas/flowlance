Stripe.api_key = ENV["stripe_secret_key"]

StripeEvent.setup do 
  subscribe 'charge.succeeded' do |event|
    user = User.where(charge_token: event.data.object.id).first
    Payment.create(user: user, amount: event.data.object.amount)
  end
end