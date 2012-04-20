Feature: Pomodoro Timer
  In order to focus on my activities
  As an Pomodoro user
  I want to manage my time using the Pomodoro technique

  Scenario: User visits the home page
    Given I want to use this cool application
    When I go to the home page
    Then I should see a text field to add activities
    And I should see a counter
    And I should see a button to start the counter

  Scenario Outline: User adds an activity
    Given I am on the home page
    When I fill in the text field with <activity>
    And I press the key enter
    Then I should see <activity>

    Scenarios:
      |activity  |
      |Activity 1|
      |Activity 2|
