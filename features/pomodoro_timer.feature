Feature: Pomodoro Timer
  In order to focus on my activities
  As an Pomodoro user
  I want to manage my time using the Pomodoro technique

  Scenario: User visits the home page
    Given I want to use this cool application
    When I go to the home page
    Then I should see a text field to add activities
    And I should see a timer
    And I should see a button to start the timer

  @javascript
  Scenario: User starts pomodoro timer
    Given I am on the home page
    And I see a timer with "25:00"
    When I click on the start button
    Then I should see a timer with "24:59"
    And I should see a button to stop the timer

  @javascript
  Scenario: User stops pomodoro timer
    Given I am on the home page
    And I've clicked on the start button
    When I click on the stop button at "24:58"
    Then I should see a button to start the timer
    And I should see a timer with "24:58"

  Scenario Outline: User adds an activity
    Given I am on the home page
    When I fill in the text field with <activity>
    And I press the key enter
    Then I should see <activity>

    Scenarios:
      |activity  |
      |Activity 1|
      |Activity 2|
