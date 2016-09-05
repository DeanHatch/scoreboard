require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  setup do
    @organization = organizations(:squeakywheel)
    session[:organization_id] = @organization.id
  end

  test "should get greet" do
    get :greet
    assert_response :success
    assert_not_nil assigns(:organization)
    assert_not_nil assigns(:competitions)
  end

  test "should get new" do
    session[:organization_id] = nil
    get :new
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.count') do
      post :create, organization: { name: "Fred Flintstone",
					phone: "(111) 555-1212",
					website: "www.id.com" }
    end
    assert_redirected_to greet_organization_path
  end


  test "should show organization" do
    get :show, id: @organization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organization
    assert_response :success
  end

  test "should update organization" do
	  patch :update, id: @organization,
			organization: { name: "Bedrock Bowling League" },
			session: { organization_id: @organization }
    assert_redirected_to greet_organization_path
  end
end
