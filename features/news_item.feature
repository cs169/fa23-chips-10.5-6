Feature: News Item

  Scenario: User can create a news item for a representative
    Given I have a representative
    Given I login in with Google
    When I visit the news item page
    Then I add a news article
    Then I fill in the form
    When I save the news item
    Then the item should be displayed