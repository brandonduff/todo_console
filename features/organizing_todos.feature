Feature: Organizing Todos

  Background:
    Given I have my current day set to "10-03-1993"

  Scenario: I can set the current day
    When I run `todo day 7-4-1776`
    And I run `todo day`
    Then stdout should contain exactly:
    """
    \n07-04-1776
    """

  Scenario: I can set todos for the current day
    Given I run `todo day 10-03-1993`
    When I run `todo new happy birthday`
    And I run `todo day 1-1-1994`
    And I run `todo new happy new year`
    And I run `todo list`
    Then stdout should contain:
    """
    happy new year
    """

    And stdout should not contain:
    """
    happy birthday
    """

  Scenario: I can set todos for the current day
    Given a non-empty list
    When I change the current day
    And I run `todo new happy new year`
    Then my todo list should only contain "happy new year"

  Scenario: I can set current day to today
    When I run `todo day today`
    Then the file "tmp/fake_home/.current_day.txt" should contain the current day

  Scenario: When setting the current day, the year defaults to the current year
    When I run `todo day 7-11`
    And I run `todo day`
    Then the current day should be set to "07-11" of the current year
    
  Scenario: I can set to nearest upcoming day by name
    When I run `todo day tuesday`
    Then the current day should be the nearest Tuesday