require "test_helper"

class PosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @po = pos(:one)
  end

  test "should get index" do
    get pos_url
    assert_response :success
  end

  test "should get new" do
    get new_po_url
    assert_response :success
  end

  test "should create po" do
    assert_difference('Po.count') do
      post pos_url, params: { po: { date_time: @po.date_time, references: @po.references, text: @po.text, title: @po.title } }
    end

    assert_redirected_to po_url(Po.last)
  end

  test "should show po" do
    get po_url(@po)
    assert_response :success
  end

  test "should get edit" do
    get edit_po_url(@po)
    assert_response :success
  end

  test "should update po" do
    patch po_url(@po), params: { po: { date_time: @po.date_time, references: @po.references, text: @po.text, title: @po.title } }
    assert_redirected_to po_url(@po)
  end

  test "should destroy po" do
    assert_difference('Po.count', -1) do
      delete po_url(@po)
    end

    assert_redirected_to pos_url
  end
end
