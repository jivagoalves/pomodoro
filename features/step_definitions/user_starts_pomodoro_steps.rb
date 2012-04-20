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

Then /^I should see a counter$/ do
  page.should have_selector('#counter')
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

Then /^I should see a button to start the counter$/ do
  page.should have_selector(
    '#start_timer[value="Start"][type="button"]'
  )
end
