Feature: Share product details to friends from amazon.

  @bose  @email_sharing @x @non_deterministic
  Scenario: Verify product details shared in email matches the original product details
    Given I login to amazon with username "1qwertyui123*123@gmail.com" and password "amazon123*"
    When I search for product "bose"

  @bose @email_sharing @non_deterministic
  Scenario Outline: Verify bose product details
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
  | bose    | qwertyui123*123@gmail.com | amazon123*      | gayathri.amazon.com@gmail.com | amazon123*     |

  @philips @email_sharing @non_deterministic
  Scenario Outline: Verify philips product details
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
  | philips | amazonUser1988@gmail.com | amazon123*      | gayathri.amazon.com@gmail.com | amazon123*    |