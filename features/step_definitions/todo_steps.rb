When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

When(/^I run todo new "([^"]*)"$/) do |arg|
  step %(I run `todo new #{arg}`)
end

When(/^I run todo list$/) do
  step %(I run `todo list`)
end

