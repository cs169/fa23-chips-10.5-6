Feature: Events

  Background: 
    Given I have a representative
    Given I login in with Google
    Given I am on the home page

  Scenario: User can access events
    Given I visit event "10"
    Then I should see "Add New Event"

  Scenario: User fills out event form incorrectly
    Given I am on the home page
    Then I create an event
    Then I should see "New event"
    Then I press "Save"
    Then I should see "County must exist"

