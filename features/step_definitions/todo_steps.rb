When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end


When(/^I change the current day$/) do
  step 'I run `todo day 1-1-1994`'
end

Then(/^my todo list should only contain "([^"]*)"$/) do |expected_output|
  step 'I run `todo list`'
  expect(last_command_started.stdout.strip).to eq(expected_output)
end


Given('a non-empty list') do
  step 'I run `todo new some stuff`'
end


Given(/^I have my current day set to "([^"]*)"$/) do |day|
  step %(a file named "tmp/fake_home/.current_day.txt" with:), day
end
