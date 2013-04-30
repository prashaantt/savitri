require 'test_helper'

class CantosControllerTest < ActionController::TestCase
  setup do
    @canto = cantos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cantos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create canto" do
    assert_difference('Canto.count') do
      post :create, canto: { no: @canto.no, description: @canto.description, title: @canto.title }
    end

    assert_redirected_to canto_path(assigns(:canto))
  end

  test "should show canto" do
    get :show, id: @canto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @canto
    assert_response :success
  end

  test "should update canto" do
    put :update, id: @canto, canto: { no: @canto.no, description: @canto.description, title: @canto.title }
    assert_redirected_to canto_path(assigns(:canto))
  end

  test "should destroy canto" do
    assert_difference('Canto.count', -1) do
      delete :destroy, id: @canto
    end

    assert_redirected_to cantos_path
  end
end
