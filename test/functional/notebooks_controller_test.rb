require 'test_helper'

class NotebooksControllerTest < ActionController::TestCase
  setup do
    @notebook = notebooks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notebooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notebook" do
    assert_difference('Notebook.count') do
      post :create, notebook: { externalurl: @notebook.externalurl, line: @notebook.line }
    end

    assert_redirected_to notebook_path(assigns(:notebook))
  end

  test "should show notebook" do
    get :show, id: @notebook
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notebook
    assert_response :success
  end

  test "should update notebook" do
    put :update, id: @notebook, notebook: { externalurl: @notebook.externalurl, line: @notebook.line }
    assert_redirected_to notebook_path(assigns(:notebook))
  end

  test "should destroy notebook" do
    assert_difference('Notebook.count', -1) do
      delete :destroy, id: @notebook
    end

    assert_redirected_to notebooks_path
  end
end
