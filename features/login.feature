Feature: Login

  Scenario: User can log in with Google
    Given I am on the login page
    When I sign in with Google
    Then I should be redirected to the home page

  Scenario: User can log in with GitHub
    Given I am on the login page
    When I sign in with GitHub
    Then I should be redirected to the home page

  Scenario: User can log out
    Given I am logged in
    When I am on the login page
    Then I should see a login profile
    Then I can logout
    Then I should be redirected to the home page
    And I should no longer be logged in
