Feature: User starts a pomodoro
  In order to focus on my activities
  As an user
  I want to manage my time using the Pomodoro technique

  Scenario: User visits the home page
    Given I want to use this cool application
    When I go to the home page
    Then I should see a form to add my activities
    And I should see a counter
