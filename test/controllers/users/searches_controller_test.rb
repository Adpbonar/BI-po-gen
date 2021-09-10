require "test_helper"

class Users::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_searches_index_url
    assert_response :success
  end
end
