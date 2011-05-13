require 'test_helper'

class StudentusersControllerTest < ActionController::TestCase
  setup do
    @studentuser = studentusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studentusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create studentuser" do
    assert_difference('Studentuser.count') do
      post :create, :studentuser => @studentuser.attributes
    end

    assert_redirected_to studentuser_path(assigns(:studentuser))
  end

  test "should show studentuser" do
    get :show, :id => @studentuser.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @studentuser.to_param
    assert_response :success
  end

  test "should update studentuser" do
    put :update, :id => @studentuser.to_param, :studentuser => @studentuser.attributes
    assert_redirected_to studentuser_path(assigns(:studentuser))
  end

  test "should destroy studentuser" do
    assert_difference('Studentuser.count', -1) do
      delete :destroy, :id => @studentuser.to_param
    end

    assert_redirected_to studentusers_path
  end
end
