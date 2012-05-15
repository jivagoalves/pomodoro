Given /^I want to use this cool application$/ do
end

When /^I (go to|am on) the home page$/ do |nothing|
  visit root_path
end

Then /^I should see a text field to add activities$/ do
  page.should have_selector(
    %Q{#add_activity form[method='post'][action='#{activities_path}']}
  )
end

Then /^I should see a timer$/ do
  page.should have_selector('#timer')
end

When /^I press the key enter$/ do
  click_on('save_activity')
end

When /^I fill in the text field with Activity (\d+)$/ do |description|
  fill_in 'activity_description', :with => description
end

Then /^I should see Activity (\d+)$/ do |description|
  page.should have_selector('.activity', :text => description)
end

Then /^I should see a button to (start|stop) the timer$/ do |action|
  page.should have_selector(
    "#start_timer[value='#{action.capitalize}'][type='button']"
  )
end

When /^I click on the start button$/ do
  click_on('start_timer')
end

Given /^I \w*\s*see a timer with "([^"]*)"$/ do |time|
  find(:xpath, "//span[@id='timer'][contains(.,'#{time}')]")
end

Given /^I've clicked on the start button$/ do
  step "I click on the start button"
end

When /^I click on the stop button at "([^"]*)"$/ do |time|
  step %Q{I see a timer with "#{time}"}
  step "I click on the start button"
end
