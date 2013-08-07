require 'test_helper'

class HealthControllerTest < ActionController::TestCase
  test "should get ping" do
    get :ping
    assert_response :success
  end

end
