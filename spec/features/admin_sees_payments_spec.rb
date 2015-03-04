require "spec_helper"
require "rails_helper" 

feature "Admin sees payments" do 
  scenario "admin can see payments" do 
    ben = User.create(name: "Ben Carson", email: "ben@example.com", password: "password")
    payment = Payment.create(amount: 2000, user: ben)

    sign_in(andy = User.create(name: "Andy Carson", email: "andy@example.com", password: "password", admin: true))
    visit admin_payments_path 

    expect(page).to have_content("$20.00")
    expect(page).to have_content("Ben Carson")
    expect(page).to have_content("ben@example.com")
  end 
  scenario "user cannot see payments" do 
    ben = User.create(name: "Ben Carson", email: "ben@example.com", password: "password")
    payment = Payment.create(amount: 2000, user: ben)

    sign_in(ben)
    visit admin_payments_path 

    expect(page).not_to have_content("$20.00")
    expect(page).not_to have_content("Ben Carson")
    expect(page).not_to have_content("ben@example.com")
  end 
end