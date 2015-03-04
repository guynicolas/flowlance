require "spec_helper"
require "rails_helper"

describe "Create payment on successfull charge" do 
  let(:event_data) do 
         {
      "id"=> "evt_15cY8IFduSPdjBxW5nYUX4EE",
      "created"=> 1425458734,
      "livemode"=> false,
      "type"=> "charge.succeeded",
      "data"=> {
        "object"=> {
          "id"=> "ch_15cY8IFduSPdjBxWocTLtCrZ",
          "object"=> "charge",
          "created"=> 1425458734,
          "livemode"=> false,
          "paid"=> true,
          "status"=> "paid",
          "amount"=> 2000,
          "currency"=> "usd",
          "refunded"=> false,
          "source"=> {
            "id"=> "card_15cY8AFduSPdjBxWEEGRC1X0",
            "object"=> "card",
            "last4"=> "4242",
            "brand"=> "Visa",
            "funding"=> "credit",
            "exp_month"=> 3,
            "exp_year"=> 2017,
            "fingerprint"=> "SPCGvyEu1FnXS4dD",
            "country"=> "US",
            "name"=> nil,
            "address_line1"=> nil,
            "address_line2"=> nil,
            "address_city"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_country"=> nil,
            "cvc_check"=> "pass",
            "address_line1_check"=> nil,
            "address_zip_check"=> nil,
            "dynamic_last4"=> nil,
            "metadata"=> {},
            "customer"=> nil
          },
          "captured"=> true,
          "card"=> {
            "id"=> "card_15cY8AFduSPdjBxWEEGRC1X0",
            "object"=> "card",
            "last4"=> "4242",
            "brand"=> "Visa",
            "funding"=> "credit",
            "exp_month"=> 3,
            "exp_year"=> 2017,
            "fingerprint"=> "SPCGvyEu1FnXS4dD",
            "country"=> "US",
            "name"=> nil,
            "address_line1"=> nil,
            "address_line2"=> nil,
            "address_city"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_country"=> nil,
            "cvc_check"=> "pass",
            "address_line1_check"=> nil,
            "address_zip_check"=> nil,
            "dynamic_last4"=> nil,
            "metadata"=> {},
            "customer"=> nil
          },
          "balance_transaction"=> "txn_15cY8IFduSPdjBxWTo6W7Kdo",
          "failure_message"=> nil,
          "failure_code"=> nil,
          "amount_refunded"=> 0,
          "customer"=> nil,
          "invoice"=> nil,
          "description"=> "Sign Up Charge for dave@example.com",
          "dispute"=> nil,
          "metadata"=> {},
          "statement_descriptor"=> nil,
          "fraud_details"=> {},
          "receipt_email"=> nil,
          "receipt_number"=> nil,
          "shipping"=> nil,
          "refunds"=> {
            "object"=> "list",
            "total_count"=> 0,
            "has_more"=> false,
            "url"=> "/v1/charges/ch_15cY8IFduSPdjBxWocTLtCrZ/refunds",
            "data"=> []
          }
        }
      },
      "object"=> "event",
      "pending_webhooks"=> 2,
      "request"=> "iar_5oAT5ihSzgEV9i",
      "api_version"=> "2014-12-22"
    }
  end 
  it "creates a payment with webhook from stripe successful charge", :vcr do 
    post "/stripe_events", event_data 
    expect(Payment.count).to eq(1)
  end 
  it "creates a payment associated wit the user", :vcr do 
    andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password", charge_token: "ch_15cY8IFduSPdjBxWocTLtCrZ")
    post '/stripe_events', event_data
    expect(Payment.first.user).to eq(andy)
  end 

  it "creates the payment wit the correct amount", :vcr do 
    andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password", charge_token: "ch_15cY8IFduSPdjBxWocTLtCrZ")
    post '/stripe_events', event_data
    expect(Payment.first.amount).to eq(2000)
  end 
end 