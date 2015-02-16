shared_examples "requires login" do 
  it "redirects to login in page" do 
    clear_current_user
    action 
    expect(response).to redirect_to login_in_path
  end 
end 