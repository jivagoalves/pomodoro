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

Given /^I have the following activities:$/ do |table|
  sorted = table.hashes.sort do |h1, h2|
    h1[:creation] <=> h2[:creation]
  end
  sorted.each do |h|
    Activity.create!(:description => h[:description])
  end
end

Then /^I should see the activities ordered as follows:$/ do |table|
  text = table.hashes.each.inject([]) do |text, h|
    text << h[:activity].to_s
  end
  page.should have_content(text.join(' '))
end
