Feature: News Item

  Background: 
    Given I have a representative
    Given I login in with Google
    Given I visit the news item page

  Scenario: User can create a news item for a representative
    When I add a news article
    Then I fill in the form
    When I save the news item
    Then the item should be displayed

  Scenario: A news item has a link to the profile page for the representative
    Given I am viewing a created news item
    When I click the representative's name
    Then their profile page is displayed
