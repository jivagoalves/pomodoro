require 'spec_helper'

feature "User tracks time for activity", js: true do
  background { FactoryGirl.create(:activity) }

  scenario "the timer is ready to use" do
    ensure_on root_path

    expect(total_spent_time).to_not have_time

    within list_of_activities do
      click_on "Start"
      expect(first_activity).to_not have_time

      after(1000).click_link("Pause")
      expect(first_activity).to_not have_time

      click_on "Resume"
      expect(first_activity).to_not have_time

      after(1000).click_link("Stop")
      expect(first_activity).to have_time
      expect(first_activity).to have_notification("Saved!")
    end

    expect(total_spent_time).to have_time
  end

  scenario "the timer is already running" do
    ensure_on root_path
    click_on "Pomodoro"

    stub_confirm_to_return(true)

    within list_of_activities do
      click_on "Start"
      expect(first_activity).to_not have_time

      after(1000).click_link("Pause")
      expect(first_activity).to_not have_time

      click_on "Resume"
      expect(first_activity).to_not have_time

      after(1000).click_link("Stop")
    end

    expect(timer).to have_content("25:00")
    expect(total_spent_time).to have_time
  end
end
