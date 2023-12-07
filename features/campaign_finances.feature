Feature: Campaign Finances

  Background:
    Given I am on the home page
    Given I am logged in
    When I click the "Campaign Finances" link
    Then I should be on the campaign finances page

  Scenario: Clicking "Campaign Finances" link should redirect to the campaign finances page
    Then I fill in the search form
    Then I press "Search"
    Then I should see "Search Results"
    Then I should see "DAN TAXATION IS THEFT BEHRMAN"
    Then I should see "50018660.4"

  