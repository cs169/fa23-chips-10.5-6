Feature: Login

  Scenario: User can log in with Google
    Given I am on the login page
    When I press "Sign in with Google"
    Then I should be redirected

  Scenario: User can log in with GitHub
    Given I am on the login page
    When I press "Sign in with GitHub"
    Then I should be redirected
