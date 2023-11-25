Feature: Accessing Representative Profile

  Scenario: User visits the representative profile page
    Given there is a representative with a profile
    When the user visits the representative profile page
    Then they should see the representative's profile details
