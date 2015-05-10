require "spec_helper"
require "rails_helper"

describe PasswordResetsController do 
  describe "GET show" do 
    it "renders the show template for valid token" do 
      andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
      andy.update_column(:token, "123456")
      get :show, id: "123456"
      expect(response).to render_template :show
    end   
    it "redirects to expired token for invalid token" do 
      get :show, id: "123456"
      expect(response).to redirect_to expired_token_path
    end 
    it "sets @token" do 
      andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
      andy.update_column(:token, "123456")
      get :show, id: "123456"
      expect(assigns(:token)).to eq("123456")
    end 
  end 

  describe "POST create" do 
    context "with valid token" do 
      it "redirects to the login in page" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "old_password")
        andy.update_column(:token, "123456")
        post :create, token: "123456", password: "new_password" 
        expect(response).to redirect_to login_path 
      end 
      it "update the user's password" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "old_password")
        andy.update_column(:token, "123456")
        post :create, token: "123456", password: "new_password"
        expect(andy.reload.authenticate("new_password")).to be_true
        expect(andy.reload.password).to eq("new_password")
      end 
      it "sets the flash success message" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "old_password")
        andy.update_column(:token, "123456")
        post :create, token: "123456", password: "new_password"
        expect(flash[:success]).to be_present
      end 
      it "regenerate the users token" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "old_password")
        andy.update_column(:token, "123456")
        post :create, token: "123456", password: "new_password"
        expect(andy.reload.token).not_to eq("123456")      
      end 
    end 
    context "with invalid token" do 
      it "redirects to the expired token page" do 
        post :create, token: "123456", password: "some_password"
        expect(response).to redirect_to expired_token_path     
      end 
    end 
  end 
end  