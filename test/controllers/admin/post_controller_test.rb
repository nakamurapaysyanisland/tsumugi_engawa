require "test_helper"

class Admin::PostControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_post_show_url
    assert_response :success
  end
end
