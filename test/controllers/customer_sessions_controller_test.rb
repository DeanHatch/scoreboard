require 'test_helper'

class CustomerSessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    @customer = customers(:alwaysright)
    post :create, customer_session: { password: 'secretpw', userid: @customer.userid }
    assert_redirected_to greet_customer_path
  end

  test "should barf on wrong password" do
    @customer = customers(:alwaysright)
    post :create, customer_session: { password: 'wrongpw', userid: @customer.userid }
    assert_redirected_to new_customer_session_path
  end

  test "should logout" do
    get :logout
    assert_redirected_to new_customer_session_path
  end

end
