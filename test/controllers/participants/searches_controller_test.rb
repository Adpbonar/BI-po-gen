require "test_helper"

class Participants::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get participants_searches_index_url
    assert_response :success
  end
end
