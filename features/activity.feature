Feature: Activities
  In order to organize my activities
  As an Pomodoro user
  I want to manage my activities

  Scenario: User has no activities
    Given I have no activities
    When I go to the home page
    Then I should see a field to add an activity with the following message:
      """
      Create your awesome activity here...
      """

  @javascript
  Scenario: User types on activity description field
    Given I am on the home page
    When I click on the field to add an activity
    Then I should see the field to add an activity with no message

  Scenario Outline: User adds an activity
    Given I am on the home page
    When I fill in the text field with <activity>
    And I press the key enter
    Then I should see <activity>

    Scenarios:
      |activity  |
      |Activity 1|
      |Activity 2|
