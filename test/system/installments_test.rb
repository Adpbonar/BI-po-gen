require "application_system_test_case"

class InstallmentsTest < ApplicationSystemTestCase
  setup do
    @installment = installments(:one)
  end

  test "visiting the index" do
    visit installments_url
    assert_selector "h1", text: "Installments"
  end

  test "creating a Installment" do
    visit installments_url
    click_on "New Installment"

    click_on "Create Installment"

    assert_text "Installment was successfully created"
    click_on "Back"
  end

  test "updating a Installment" do
    visit installments_url
    click_on "Edit", match: :first

    click_on "Update Installment"

    assert_text "Installment was successfully updated"
    click_on "Back"
  end

  test "destroying a Installment" do
    visit installments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Installment was successfully destroyed"
  end
end
