Feature: Share product details to friends from amazon.

  @email_sharing
  Scenario Outline: Verify product details shared in email matches the original product details
    Given I login to amazon with username "<amazon_username>" and password "<amazon_password>"
    When I search for product "<product>"
    And I select the first product
    Then I choose to share the product information by email to my friend at "<gmail_username>"

    Given my friend logins to her gmail with username "<gmail_username>" and password "<gmail_password>"
    When she opens my email
    Then she should be seeing the same email content as sent from amazon

    When she visits the product link shared
    Then she should be seeing the same product details like when I shared

  Examples:
    | product | amazon_username         | amazon_password | gmail_username                | gmail_password |
    | bose    | amazonUser1988@gmail.com | amazon123*      | gayathri.amazon.com@gmail.com | amazon123*     |
#    | philips | amazonUser1988@gmail.com | amazon123*      | gayathri.amazon.com@gmail.com | amazon123*     |