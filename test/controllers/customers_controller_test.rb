require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = customers(:one)
  end

  test "should get greet" do
    get :greet
    assert_response :success
    assert_not_nil assigns(:customer)
    assert_not_nil assigns(:competitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, customer: { userid: "user@id.com",
					password: "yabba",
					password_confirmation: "yabba",
					name: "Fred Flintstone",
					phone: "(111) 555-1212",
					websitee: "www.id.com" }
    end

    assert_redirected_to edit_customer_path
  end

  test "should show customer" do
    get :show, id: @customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer
    assert_response :success
  end

  test "should update customer" do
    patch :update, id: @customer, customer: { name: "Bedrock Bowling League" }
    assert_redirected_to greet_customer_path(@customer)
  end
end
