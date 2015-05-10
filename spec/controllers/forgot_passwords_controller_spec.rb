require "spec_helper"
require "rails_helper"

describe ForgotPasswordsController do 
  describe "POST create" do 
    context "with blank input" do 
      it "redirects to the forgot password page" do 
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
      end 
      it "shows an error message" do 
        post :create, email: ""
        expect(flash[:danger]).to eq("Email cannot be blank!")
      end 
    end 
    context "with existing email" do 
      it "redirects to the forgot password confirmation page" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
        post :create, email: "andy@example.com"
        expect(response).to redirect_to forgot_password_confirmation_path
      end 
      it "sends an email to the email address" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
        post :create, email: "andy@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["andy@example.com"])
      end 
    end 
    context "with non-existent email" do 
      it "redirects to the forgot password page" do 
        post :create, email: "foo@example.com"
        expect(response).to redirect_to forgot_password_path
      end 
      it "shows and error message" do 
        post :create, email: "foo@example.com"
        expect(flash[:danger]).to eq("This email was not found in our database. Please try again!" )
      end 
    end 
  end 
end 