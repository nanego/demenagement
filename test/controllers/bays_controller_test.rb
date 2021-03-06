require File.expand_path("../../test_helper", __FILE__)

class BaysControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @bay = bays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bays)
  end

  test "should show bay" do
    get :show, params: {id: @bay}
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bay" do
    assert_difference('Bay.count') do
      post :create, params: {bay: { name: @bay.name }}
    end

    assert_redirected_to bays_path
  end

  test "should get edit" do
    get :edit, params: {id: @bay}
    assert_response :success
  end

  test "should update bay" do
    patch :update, params: {id: @bay, bay: { name: @bay.name }}
    assert_redirected_to bays_path
  end

  test "should destroy bay" do
    assert_difference('Bay.count', -1) do
      delete :destroy, params: {id: @bay}
    end

    assert_redirected_to bays_path
  end
end
