require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = build(:user)
    @saved_user = create(:user)
  end

  test"should get new" do
    get new_user_session_url
    assert_response:success
  end

  test"should creat user" do
    assert_difference('User.count') do
      post user_registration_path, params:{
        user:{
          email: @user.email,
          password: @user.password,
          password_confirmation: @user.password_confirmation,
          username: @user.username
        }
      }
    end
    assert_redirected_to root_url
  end

  test"should show user profile" do
    @user.save
    assert @user.valid?
    get user_url(@user)
    assert_response:success
  end

  test"should get edit profile"do
    @user.save
    get edit_user_registration_url(@user)
  end

  test"should get update profile" do
   patch user_registration_url(@saved_user),params:{
     user:{
       email: @saved_user.email,
       password: @saved_user.password,
       password_confirmation: @saved_user.password_confirmation,
       username: @saved_user.username,
       current_password: @saved_user.current_password
     }
   }
   # assert_redirected_to root_url
 end



end
