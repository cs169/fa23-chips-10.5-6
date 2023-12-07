Feature: Campaign Finances

  Scenario: Filling "Campaign Finances" link should work
    Given I am on the home page
    When I click the "Campaign Finances" link
    Then I should be on the campaign finances page
    Then I fill in the search form
