Feature: Search

  Background: 
    Given I have a representative
    Given I login in with Google
    Given I am on the representatives page

  Scenario: User can search by state
    When I fill in "address" with "California"
    Then I press "Search"
    Then I should see "Joseph R. Biden"
    Then I should see "Malia M. Cohen"
    Then I should see "Patricia Guerrero"


  Scenario: User can search by zip code
    When I fill in "address" with "20500"
    Then I press "Search"
    Then I should see "D.C. City Council Member"
    Then I should see "Brian Schwalb"
    Then I should see "Muriel Bowser"
