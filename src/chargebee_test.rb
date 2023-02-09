require 'chargebee'
ChargeBee.configure(
  site: ENV.fetch('CHARGEBEE_SITE'),
  api_key: ENV.fetch('CHARGEBEE_API_KEY')
)

puts "will print coupons"

coupons = ChargeBee::Coupon.list({
    :limit=>5,
  })
  coupons.each do |entry|
  puts entry.coupon
end



  puts " will try Estimate api"
  params = {
    :billing_address => {
      :line1 => "PO Box 9999",
      :city => "Walnut",
      :zip => "91789",
      :country => "US"
      },
    :subscription => {
      :plan_id => "value-premium"
      }
  }
  result = ChargeBee::Estimate.create_subscription(params)

  puts result

  puts "will try hostedpage api"

result = ChargeBee::HostedPage.checkout_new({
  :billing_address => {
    :first_name => "John",
    :last_name => "Doe",
    :line1 => "PO Box 9999",
    :city => "Walnut",
    :state => "California",
    :zip => "91789",
    :country => "US"
    },
  :subscription => {
    :plan_id => "no_trial"
    },
  :customer => {
    :email => "john@user.com",
    :first_name => "John",
    :last_name => "Doe",
    :locale => "fr-CA",
    :phone => "+1-949-999-9999"
    }
  })

  puts result