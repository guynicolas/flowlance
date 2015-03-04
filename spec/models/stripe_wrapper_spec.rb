require 'spec_helper'
require 'rails_helper'

describe StripeWrapper do 
  describe StripeWrapper::Charge do 
    describe ".create" do 

      it "makes a successful charge", :vcr do 
        token = Stripe::Token.create(
          :card => {
            :number => "4242424242424242",
            :exp_month => 2,
            :exp_year => 2016,
            :cvc => "314"
          },
        ).id 
        response = StripeWrapper::Charge.create(
          amount: 2000, 
          card: token, 
          description: "a valid charge"
          )
        expect(response).to be_successful 
      end 

      it "makes a charge declined card", :vcr do 
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 2,
            :exp_year => 2016,
            :cvc => "314"
          },
        ).id 
        response = StripeWrapper::Charge.create(
          amount: 2000, 
          card: token, 
          description: "an invalid charge"
          )
        expect(response).not_to be_successful 
      end 

      it "returns an error message for declined cards", :vcr do 
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 2,
            :exp_year => 2016,
            :cvc => "314"
          },
        ).id 
        response = StripeWrapper::Charge.create(
          amount: 2000, 
          card: token, 
          description: "an invalid charge"
          )
        expect(response.error_message).to eq("Your card was declined.")
      end 
    end 
  end 
end 