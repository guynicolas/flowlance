def current_user 
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil 
end 

def sign_in(a_user=nil)
  user = (a_user || user = User.create(name: "Andy Carson", email: "andy@example.com", password: "password"))
  visit login_path 
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end