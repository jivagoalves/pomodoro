require 'spec_helper'

feature "User creates activity", js: true do
  scenario "with blank description" do
    ensure_on root_path

    within activity_form do
      fill_in "Description", with: ""
      click_on "Add"
    end

    expect(activity_form).to have_content("Can't be blank")
    expect(list_of_activities).to_not have_activities
  end

  scenario "with some text for description" do
    ensure_on root_path

    within activity_form do
      fill_in "Description", with: "My description"
      click_on "Add"
    end

    expect(list_of_activities).to have_content("My description")
    expect(list_of_activities).to have_activities
  end
end
