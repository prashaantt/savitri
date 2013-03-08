require 'test_helper'

class StanzasControllerTest < ActionController::TestCase
  setup do
    @stanza = stanzas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stanzas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stanza" do
    assert_difference('Stanza.count') do
      post :create, stanza: { no: @stanza.no }
    end

    assert_redirected_to stanza_path(assigns(:stanza))
  end

  test "should show stanza" do
    get :show, id: @stanza
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stanza
    assert_response :success
  end

  test "should update stanza" do
    put :update, id: @stanza, stanza: { no: @stanza.no }
    assert_redirected_to stanza_path(assigns(:stanza))
  end

  test "should destroy stanza" do
    assert_difference('Stanza.count', -1) do
      delete :destroy, id: @stanza
    end

    assert_redirected_to stanzas_path
  end
end
