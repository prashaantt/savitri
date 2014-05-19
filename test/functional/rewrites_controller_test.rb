require 'test_helper'

class RewritesControllerTest < ActionController::TestCase
  setup do
    @rewrite = rewrites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rewrites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rewrite" do
    assert_difference('Rewrite.count') do
      post :create, rewrite: { code: @rewrite.code, destination: @rewrite.destination, source: @rewrite.source }
    end

    assert_redirected_to rewrite_path(assigns(:rewrite))
  end

  test "should show rewrite" do
    get :show, id: @rewrite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rewrite
    assert_response :success
  end

  test "should update rewrite" do
    put :update, id: @rewrite, rewrite: { code: @rewrite.code, destination: @rewrite.destination, source: @rewrite.source }
    assert_redirected_to rewrite_path(assigns(:rewrite))
  end

  test "should destroy rewrite" do
    assert_difference('Rewrite.count', -1) do
      delete :destroy, id: @rewrite
    end

    assert_redirected_to rewrites_path
  end
end
