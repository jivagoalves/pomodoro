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

  Scenario: User sees most recent activities first
    Given I have the following activities:
      |description            |creation   |
      |I'm the oldest one     |2011-05-15 |
      |Finish basic features  |2012-05-10 |
      |Test everything        |2012-05-11 |
    When I go to the home page
    Then I should see the activities ordered as follows:
      |activity             |
      |Test everything      |
      |Finish basic features|
      |I'm the oldest one   |
