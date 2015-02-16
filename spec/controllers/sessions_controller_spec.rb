require "spec_helper"
require "rails_helper"

describe SessionsController do 
  describe "GET new" do 
    it "renders the new template for unauthenticated users" do 
      get :new 
      expect(response).to render_template :new
    end 
    it "redirects authenticated users to home page" do 
      andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
      session[:user_id] = andy.id
      get :new
      expect(response).to redirect_to home_path
    end 
  end 

  describe "POST create" do 
    context "with valid credentials" do 
      it "redirects the user to the home page" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
        post :create, email: andy.email, password: andy.password
        expect(response).to redirect_to home_path
      end 
      it "puts the current user in the session" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
        post :create, email: andy.email, password: andy.password
        expect(session[:user_id]).to eq(andy.id)
      end 
      it "sets a welcome message" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
        post :create, email: andy.email, password: andy.password
        expect(flash[:success]).not_to be_blank       
      end 
    end 
    context "with invalid credentials" do 
      it "redirects to the new template" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
        post :create, email: andy.email
        expect(response).to redirect_to login_path
      end 
      it "does not put the user in session" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
        post :create, email: andy.email
        expect(session[:user_id]).to eq(nil)
      end 

      it "sets the error message" do 
        andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
        post :create, email: andy.email
        expect(flash[:danger]).not_to be_blank
      end 
    end
  end 

  describe "GET destroy" do 
    before do 
      andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
      session[:user_id] = andy.id
      get :destroy
    end 
    it "redirects to the root path" do 
      expect(response).to redirect_to root_path
    end 
    it "clears user from session" do 
      expect(session[:user_id]).to be_nil
    end 
    it "sets a notice" do 
      expect(flash[:success]).not_to be_blank
    end 
  end 
end 