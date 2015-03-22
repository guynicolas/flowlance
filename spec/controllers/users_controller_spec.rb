require 'spec_helper'
require 'rails_helper'

describe UsersController do 
  describe "GET new" do 
    it "sets @user" do 
      get :new 
      expect(assigns(:user)).to be_instance_of(User)
    end 
  end 
  describe "POST create" do 
    context 'with valid personal info' do 
      after { ActionMailer::Base.deliveries.clear }
      it "redirects to the sign in page" do
        post :create, user: {name: "Andy Carson", email: "andy@example.com", password: "password"}, stripeToken: '12345'
        expect(response).to redirect_to login_path 
      end 
      it "it create a user" do 
        post :create, user: {name: "Andy Carson", email: "andy@example.com", password: "password"}, stripeToken: '12345'
        expect(User.count).to eq(1)
      end 
      it "sends a welcome email" do 
        post :create, user: {name: "Andy Carson", email: "andy@example.com", password: "password"}, stripeToken: '12345'
        expect(ActionMailer::Base.deliveries.last.to).to eq(["andy@example.com"])
      end 
    end 
    context 'with invalid personal info' do 
      it "it renders to new template" do 
        post :create, user: {email: "andy@example.com", password: "password"}  
        expect(response).to render_template :new       
      end 
      it "sets an error message" do 
        post :create, user: {email: "andy@example.com", password: "password"}  
        expect(flash[:danger]).to be_present
      end 
      it "does not charge the card" do 
        post :create, user: {email: "andy@example.com", password: "password"}   
      end 
    end 
  end 
end 