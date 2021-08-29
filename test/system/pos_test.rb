require "application_system_test_case"

class PosTest < ApplicationSystemTestCase
  setup do
    @po = pos(:one)
  end

  test "visiting the index" do
    visit pos_url
    assert_selector "h1", text: "Pos"
  end

  test "creating a Po" do
    visit pos_url
    click_on "New Po"

    fill_in "Date time", with: @po.date_time
    fill_in "References", with: @po.references
    fill_in "Text", with: @po.text
    fill_in "Title", with: @po.title
    click_on "Create Po"

    assert_text "Po was successfully created"
    click_on "Back"
  end

  test "updating a Po" do
    visit pos_url
    click_on "Edit", match: :first

    fill_in "Date time", with: @po.date_time
    fill_in "References", with: @po.references
    fill_in "Text", with: @po.text
    fill_in "Title", with: @po.title
    click_on "Update Po"

    assert_text "Po was successfully updated"
    click_on "Back"
  end

  test "destroying a Po" do
    visit pos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Po was successfully destroyed"
  end
end
