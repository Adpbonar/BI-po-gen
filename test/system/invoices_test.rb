require "application_system_test_case"

class InvoicesTest < ApplicationSystemTestCase
  setup do
    @invoice = invoices(:one)
  end

  test "visiting the index" do
    visit invoices_url
    assert_selector "h1", text: "Invoices"
  end

  test "creating a Invoice" do
    visit invoices_url
    click_on "New Invoice"

    fill_in "Description", with: @invoice.description
    fill_in "Name,", with: @invoice.name,
    fill_in "Participant", with: @invoice.participant_id
    fill_in "Po", with: @invoice.po_id
    fill_in "Tax rate", with: @invoice.tax_rate
    click_on "Create Invoice"

    assert_text "Invoice was successfully created"
    click_on "Back"
  end

  test "updating a Invoice" do
    visit invoices_url
    click_on "Edit", match: :first

    fill_in "Description", with: @invoice.description
    fill_in "Name,", with: @invoice.name,
    fill_in "Participant", with: @invoice.participant_id
    fill_in "Po", with: @invoice.po_id
    fill_in "Tax rate", with: @invoice.tax_rate
    click_on "Update Invoice"

    assert_text "Invoice was successfully updated"
    click_on "Back"
  end

  test "destroying a Invoice" do
    visit invoices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Invoice was successfully destroyed"
  end
end
