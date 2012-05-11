Given /^I have no activities$/ do
  Activity.all.each { |act| act.destroy }
end

Then /^I should see a field to add an activity with the following message:$/ do |msg|
  page.should have_css("#activity_description[value='#{msg}']")
end

When /^I click on the field to add an activity$/ do
  find('#activity_description').click
end

Then /^I should see the field to add an activity with no message$/ do
  step "I should see a field to add an activity with the following message:", ""
end

