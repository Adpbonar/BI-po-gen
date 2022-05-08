require "application_system_test_case"

class RankingFormsTest < ApplicationSystemTestCase
  setup do
    @ranking_form = ranking_forms(:one)
  end

  test "visiting the index" do
    visit ranking_forms_url
    assert_selector "h1", text: "Ranking Forms"
  end

  test "creating a Ranking form" do
    visit ranking_forms_url
    click_on "New Ranking Form"

    click_on "Create Ranking form"

    assert_text "Ranking form was successfully created"
    click_on "Back"
  end

  test "updating a Ranking form" do
    visit ranking_forms_url
    click_on "Edit", match: :first

    click_on "Update Ranking form"

    assert_text "Ranking form was successfully updated"
    click_on "Back"
  end

  test "destroying a Ranking form" do
    visit ranking_forms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ranking form was successfully destroyed"
  end
end
