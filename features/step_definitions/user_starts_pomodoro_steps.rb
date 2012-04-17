Given /^I want to use this cool application$/ do
end

When /^I go to the home page$/ do
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
