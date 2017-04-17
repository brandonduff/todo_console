Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "todo"
    Then the exit status should be 0

  Scenario: I can create new tasks
    When I run `todo new "hi"`
    And I run todo list
    Then the stdout should contain "hi"
    