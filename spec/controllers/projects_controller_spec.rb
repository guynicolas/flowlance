require "spec_helper"
require "rails_helper"

describe ProjectsController do 
  describe "GET index" do 
    it "redirects unathenticated users to login page" do 
      project = Project.create(title: "Annual Report", description: "Translation", volume: "5000", amount_due: "400", client_name: "Anderson & Co. Ltd")
      get :index
      expect(response).to redirect_to login_path
    end 
    it "displays projects that belong to current user" do 
      andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
      session[:user_id] = andy.id
      project = Project.create(title: "Annual Report", description: "Translation", volume: "5000", amount_due: "400", client_name: "Anderson & Co. Ltd", user_id: andy.id)
      get :index
      expect(andy.projects).to eq([project])
    end 
  end 

  describe "GET new" do 
    it "sets @project" do 
      andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
      session[:user_id] = andy.id
      get :new 
      expect(assigns(:project)).to be_instance_of(Project)
    end 
  end 
  describe "POST create" do 
    context "with valid inputs" do 
      before do 
      andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
      session[:user_id] = andy.id
        post :create, project: {title: "Annual Report", description: "Translation", volume: "5000", amount_due: "400", client_name: "Anderson & Co. Ltd" }
      end 
      it "redirects to the home page" do 
        expect(response).to redirect_to home_path
      end 
      it "creates a project" do 
        expect(Project.count).to eq(1)
      end 
      it "sets a success message" do 
        expect(flash[:success]).not_to be_blank
      end 
    end 
    context "with invalid inputs" do 
      before do 
      andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
      session[:user_id] = andy.id
        post :create, project: {title: "Annual Report", description: "Translation" } 
      end 
      it "renders the new template" do 
        expect(response).to render_template :new
      end 
      it "does not create a project" do 
        expect(Project.count).to eq(0) 
      end 
      it "sets an error message" do 
        expect(flash[:danger]).not_to be_blank
      end 
    end 
  end 
end 