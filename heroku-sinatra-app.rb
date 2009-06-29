# You'll need to require these if you
# want to develop while running with ruby.
# The config/rackup.ru requires these as well
# for it's own reasons.
#
# $ ruby heroku-sinatra-app.rb
#
require 'rubygems'
require 'sinatra'

require 'vendor/frozen'
require 'sinatra'
require 'money'
require 'paypal'


configure :production do
  # Configure stuff here you'll want to
  # only be run at Heroku at boot

  # TIP:  You can get you database information
  #       from ENV['DATABASE_URI'] (see /env route below)
end

# Quick test
# get '/' do
#   "Congradulations!
#    You're running a Sinatra application on Heroku!"
# end

# Test at <appname>.heroku.com

# You can see all your app specific information this way.
# IMPORTANT! This is a very bad thing to do for a production
# application with sensitive information

# get '/env' do
#   ENV.inspect
# end

# =========== NEW ============

get '/' do
  File.read('payment.html')
end

get '/paid' do
  "Thanks for your payment. <pre>#{params.inspect}</pre>"
end

# http://dist.leetsoft.com/api/paypal/
post '/ipn' do
  ipn_data = request.env["rack.input"].read
  ipn = Paypal::Notification.new(ipn_data)

  if ipn.acknowledge
    puts "PayPal IPN acknowledged successfully:"
  else
    puts "PayPal IPN failed to acknowledge:"
  end
  p ipn.inspect

  return nil
end

