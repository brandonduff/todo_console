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

Then(/^the file "([^"]*)" should contain the current day$/) do |file|
  step %(the file "#{file}" should contain "#{Date.today.strftime("%d-%m-%Y")}")
end

Then(/^the current day should be set to "([^"]*)" of the current year$/) do |date|
  step %(the file "tmp/fake_home/.current_day.txt" should contain "#{Date.parse(date + "-#{Date.today.strftime("%Y")}").strftime("%d-%m-%Y")}")
end

Then(/^the current day should be the nearest Tuesday$/) do
  step %(the file "tmp/fake_home/.current_day.txt" should contain "#{Date.parse('Tuesday').strftime("%d-%m-%Y")}")
end
