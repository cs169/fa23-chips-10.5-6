Feature: Navbar functionality

  Scenario: Navigation links should be present
    Given I am on the home page
    Then I should see a link to "Home"
    And I should see a link to "Representatives"
    And I should see a link to "Login"

  Scenario: Clicking "Home" link should redirect to the home page
    Given I am on the home page
    When I click the "Home" link
    Then I should be on the home page

  Scenario: Clicking "Representatives" link should redirect to the representatives page
    Given I am on the home page
    When I click the "Representatives" link
    Then I should be on the representatives page

  Scenario: Clicking "Login" link should redirect to the login page
    Given I am on the home page
    When I click the "Login" link
    Then I should be on the login page

    Scenario: Clicking "Campaign Finances" link should redirect to the campaign finances page
    Given I am on the home page
    When I click the "Campaign Finances" link
    Then I should be on the campaign finances page
