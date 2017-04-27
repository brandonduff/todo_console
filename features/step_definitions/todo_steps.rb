When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

When(/^I run todo new "([^"]*)"$/) do |arg|
  step %(I run `todo new #{arg}`)
end

Then(/^I should have the todo "([^"]*)" in my home$/) do |todo|
  contents = File.read("#{Dir.home}/.todos.txt")
  expect(contents).to eq(todo)
end