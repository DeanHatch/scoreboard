require 'test_helper'

class CompetitionsControllerTest < ActionController::TestCase
  setup do
    #~ @customer = customers(:alwaysright)
    #~ session[:customer_id] = @customer.id
    #~ @competition = competitions(:soccer)
    @customer = customers(:squeakywheel)
    session[:customer_id] = @customer.id
    @competition = competitions(:bball)
  end

  #~ test "should get index" do
    #~ get :index, customer_id: @customer.id
    #~ assert_response :success
    #~ assert_not_nil assigns(:competitions)
  #~ end

  #~ test "should get new" do
    #~ get :new
    #~ assert_response :success
  #~ end

  #~ test "should create competition" do
    #~ assert_difference('Competition.count') do
      #~ post :create, competition: { drawpoints: @competition.drawpoints, forfeitlossscore: @competition.forfeitlossscore, forfeitpoints: @competition.forfeitpoints, forfeitwinscore: @competition.forfeitwinscore, keepscores: @competition.keepscores, losspoints: @competition.losspoints, name: @competition.name, playoffbracket: @competition.playoffbracket, playoffbracketlabel: @competition.playoffbracketlabel, poolgroupseason: @competition.poolgroupseason, poolgroupseasonlabel: @competition.poolgroupseasonlabel, sport: @competition.sport, variety: @competition.variety, winpoints: @competition.winpoints }
    #~ end

    #~ assert_redirected_to competition_path(assigns(:competition))
  #~ end

  #~ test "should show competition" do
    #~ get :show, id: @competition
    #~ assert_response :success
  #~ end

  #~ test "should get edit" do
    #~ get :edit, id: @competition
    #~ assert_response :success
  #~ end

  #~ test "should update competition" do
    #~ patch :update, id: @competition, competition: { drawpoints: @competition.drawpoints, forfeitlossscore: @competition.forfeitlossscore, forfeitpoints: @competition.forfeitpoints, forfeitwinscore: @competition.forfeitwinscore, keepscores: @competition.keepscores, losspoints: @competition.losspoints, name: @competition.name, playoffbracket: @competition.playoffbracket, playoffbracketlabel: @competition.playoffbracketlabel, poolgroupseason: @competition.poolgroupseason, poolgroupseasonlabel: @competition.poolgroupseasonlabel, sport: @competition.sport, variety: @competition.variety, winpoints: @competition.winpoints }
    #~ assert_redirected_to competition_path(assigns(:competition))
  #~ end

  #~ test "should destroy competition" do
    #~ assert_difference('Competition.count', -1) do
      #~ delete :destroy, id: @competition
    #~ end

    #~ assert_redirected_to competitions_path
  #~ end
end
