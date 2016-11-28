require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid username failure" do
    get signup_path
    assert_template 'signup'
    assert_no_difference 'User.count' do
      post users_path, user: { username:  " ", email: "user@example.com", password: "password" }
    end
    assert_template 'users/new'
  end
  
  test "invalid email failure" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { username:  "User", email: "user", password: "password" }
    end
    assert_template 'users/new'
  end

  test "invalid password failure" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { username:  "User", email: "user@example.com", password: "" }
    end
    assert_template 'users/new'
end  
  
end