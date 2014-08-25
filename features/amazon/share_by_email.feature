Feature: Share product details by email

  Scenario: Verify product details shared in email matches the original product details
    Given I login to amazon
    When I search for product "bose"
    And I select the first product
    Then I choose to share the product information by email to my friend at "gayathri.amazon.com@gmail.com"

    Given my friend logins to her gmail
    When she opens my email
    Then she should be seeing the same email content as sent from amazon
    And the sku of the product shared in the link should be the original sku of the product

    When she visits the product link shared
    Then she should be seeing the same product details like when I shared