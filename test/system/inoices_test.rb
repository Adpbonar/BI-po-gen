require "application_system_test_case"

class InoicesTest < ApplicationSystemTestCase
  setup do
    @inoice = inoices(:one)
  end

  test "visiting the index" do
    visit inoices_url
    assert_selector "h1", text: "Inoices"
  end

  test "creating a Inoice" do
    visit inoices_url
    click_on "New Inoice"

    fill_in "Description", with: @inoice.description
    fill_in "Name,", with: @inoice.name,
    fill_in "Participant", with: @inoice.participant_id
    fill_in "Po", with: @inoice.po_id
    fill_in "Tax rate", with: @inoice.tax_rate
    click_on "Create Inoice"

    assert_text "Inoice was successfully created"
    click_on "Back"
  end

  test "updating a Inoice" do
    visit inoices_url
    click_on "Edit", match: :first

    fill_in "Description", with: @inoice.description
    fill_in "Name,", with: @inoice.name,
    fill_in "Participant", with: @inoice.participant_id
    fill_in "Po", with: @inoice.po_id
    fill_in "Tax rate", with: @inoice.tax_rate
    click_on "Update Inoice"

    assert_text "Inoice was successfully updated"
    click_on "Back"
  end

  test "destroying a Inoice" do
    visit inoices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inoice was successfully destroyed"
  end
end
