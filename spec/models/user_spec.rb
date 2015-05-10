require "spec_helper"
require "rails_helper"
describe User do 
  it "generates a random token" do 
    andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password")
    expect(andy.token).to be_present
  end 
end 