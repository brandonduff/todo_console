Feature: Todos App
  Background:
    Given a file named "tmp/fake_home/.current_day.txt" with:
    """
    10-03-1993
    """
  Scenario: I can create new tasks

    When I run `todo new hi`
    And I run `todo new guy`
    Then the file "tmp/fake_home/todos/10-03-1993.txt" should contain "hi\nguy"

  Scenario: I can list my existing tasks
    Given a file named "tmp/fake_home/todos/10-03-1993.txt" with:
    """
    Wash the dishes
    Clean the garage

    """
    When I run `todo list`
    Then stdout should contain exactly:
    """
    Wash the dishes
    Clean the garage

    """

  Scenario: I only see unfinished todos by default
    Given a file named "tmp/fake_home/todos/10-03-1993.txt" with:
    """
    ✓ Wash the dishes
    Clean the garage
    """
    When I run `todo list`
    Then stdout should contain exactly:
    """
    Clean the garage
    """

  Scenario: I can mark the top todo as done
    Given a file named "tmp/fake_home/todos/10-03-1993.txt" with:
    """
    Wash the dishes
    Clean the garage

    """
    When I run `todo done`
    Then stdout should contain:
    """
    ✓ Wash the dishes
    Clean the garage

    """

  Scenario: I can mark the second todo as done
    Given a file named "tmp/fake_home/todos/10-03-1993.txt" with:
    """
    ✓ Wash the dishes
    Clean the garage

    """
    When I run `todo done`
    And I run `todo list -a`
    Then stdout should contain:
    """
    ✓ Wash the dishes
    ✓ Clean the garage

    """

  Scenario: I can clear done todos
    Given a file named "tmp/fake_home/todos/10-03-1993.txt" with:
    """
    \n✓ Wash the dishes
    Clean the garage
    """
    When I run `todo clear`
    And I run `todo list -a`
    Then stdout should contain exactly:
    """
    \nClean the garage
    """

  Scenario: I can undo the last done todo
    Given a file named "tmp/fake_home/todos/10-03-1993.txt" with:
    """
    ✓ Wash the dishes
    Clean the garage
    """
    When I run `todo undo`
    Then stdout should contain exactly:
    """
    Wash the dishes
    Clean the garage
    """

  Scenario: I can set the current day
    When I run `todo day 7-4-1776`
    And I run `todo day`
    Then stdout should contain exactly:
     """
     \n7-4-1776
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

