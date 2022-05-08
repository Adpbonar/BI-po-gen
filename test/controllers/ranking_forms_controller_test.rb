require "test_helper"

class RankingFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ranking_form = ranking_forms(:one)
  end

  test "should get index" do
    get ranking_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_ranking_form_url
    assert_response :success
  end

  test "should create ranking_form" do
    assert_difference('RankingForm.count') do
      post ranking_forms_url, params: { ranking_form: {  } }
    end

    assert_redirected_to ranking_form_url(RankingForm.last)
  end

  test "should show ranking_form" do
    get ranking_form_url(@ranking_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_ranking_form_url(@ranking_form)
    assert_response :success
  end

  test "should update ranking_form" do
    patch ranking_form_url(@ranking_form), params: { ranking_form: {  } }
    assert_redirected_to ranking_form_url(@ranking_form)
  end

  test "should destroy ranking_form" do
    assert_difference('RankingForm.count', -1) do
      delete ranking_form_url(@ranking_form)
    end

    assert_redirected_to ranking_forms_url
  end
end
