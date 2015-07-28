Feature: As a app user, I should be able to successfully login.

  Scenario: Verify on successful login, user is navigated to home page. Verify password is masked.
    Given I am on the login page
    When I sign in with username "U2" and password "U2"
    Then I should be landed on home page

