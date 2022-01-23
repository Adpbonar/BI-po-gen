require "test_helper"

class InoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inoice = inoices(:one)
  end

  test "should get index" do
    get inoices_url
    assert_response :success
  end

  test "should get new" do
    get new_inoice_url
    assert_response :success
  end

  test "should create inoice" do
    assert_difference('Inoice.count') do
      post inoices_url, params: { inoice: { description: @inoice.description, name,: @inoice.name,, participant_id: @inoice.participant_id, po_id: @inoice.po_id, tax_rate: @inoice.tax_rate } }
    end

    assert_redirected_to inoice_url(Inoice.last)
  end

  test "should show inoice" do
    get inoice_url(@inoice)
    assert_response :success
  end

  test "should get edit" do
    get edit_inoice_url(@inoice)
    assert_response :success
  end

  test "should update inoice" do
    patch inoice_url(@inoice), params: { inoice: { description: @inoice.description, name,: @inoice.name,, participant_id: @inoice.participant_id, po_id: @inoice.po_id, tax_rate: @inoice.tax_rate } }
    assert_redirected_to inoice_url(@inoice)
  end

  test "should destroy inoice" do
    assert_difference('Inoice.count', -1) do
      delete inoice_url(@inoice)
    end

    assert_redirected_to inoices_url
  end
end
