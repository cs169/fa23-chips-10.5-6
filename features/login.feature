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


  Scenario: User cannot edit if logged out
    Given I have a representative
    Given I am logged in
    When I visit the news item page
    When I add a news article
    Then I fill in the form
    When I save the news item
    Then the item should be displayed
    When I am on the login page
    Then I should see a login profile
    Then I can logout
    Then I should be redirected to the home page
    And I should no longer be logged in
    Given I visit the news item page
    When I follow "Edit"
    Then I should see "Sign In"
    Then I should see "Select an authentication provider below to login."
    Then I sign in with GitHub

