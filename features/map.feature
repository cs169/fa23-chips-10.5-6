Feature: Map

  Background: 
    Given I have a representative
    Given I login in with Google
    Given I am on the home page

  Scenario: Correct page
    Then I should see "National Map"

  Scenario: Correct county
    When I click "Yolo County" on state map
    Then I should see "Yolo County Sheriff-Coroner"
