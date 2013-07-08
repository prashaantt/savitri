require 'test_helper'

class AudiosControllerTest < ActionController::TestCase
  setup do
    @audio = audios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:audios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create audio" do
    assert_difference('Audio.count') do
      post :create, audio: { audio_url: @audio.audio_url, author: @audio.author, block: @audio.block, closedcaptioned: @audio.closedcaptioned, explicit: @audio.explicit, file_size: @audio.file_size, order: @audio.order, seconds: @audio.seconds, summary: @audio.summary, title: @audio.title, url: @audio.url }
    end

    assert_redirected_to audio_path(assigns(:audio))
  end

  test "should show audio" do
    get :show, id: @audio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @audio
    assert_response :success
  end

  test "should update audio" do
    put :update, id: @audio, audio: { audio_url: @audio.audio_url, author: @audio.author, block: @audio.block, closedcaptioned: @audio.closedcaptioned, explicit: @audio.explicit, file_size: @audio.file_size, order: @audio.order, seconds: @audio.seconds, summary: @audio.summary, title: @audio.title, url: @audio.url }
    assert_redirected_to audio_path(assigns(:audio))
  end

  test "should destroy audio" do
    assert_difference('Audio.count', -1) do
      delete :destroy, id: @audio
    end

    assert_redirected_to audios_path
  end
end
