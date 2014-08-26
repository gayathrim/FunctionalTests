Given(/^my friend logins to her gmail$/) do
  @session=Capybara::Session.new(:selenium)
  gmail_sign_in_page=GmailLoginPage.new(@session)
  gmail_sign_in_page.goto_gmail_login
  gmail_sign_in_page.sign_in_with_credentials("gayathri.amazon.com@gmail.com","amazon123*")
end

When(/^she opens my email$/) do
  @inboxPrimaryTab=InboxPrimaryPage.new(@session)
  @inboxPrimaryTab.open_email_from_amazon
end

Then(/^she should be seeing the same email content as sent from amazon$/) do
  @product_details_on_email=Hash.new
  @product_details_on_email[:email_content]=@inboxPrimaryTab.collect_product_info_from_mail
  raise "Email content did not match. Expected: '#{@product_details_before_sharing[:email_content]}' Got: '#{@product_details_on_email[:email_content]}'" unless (@product_details_before_sharing[:email_content]==@product_details_on_email[:email_content])
end

And(/^the sku of the product shared in the link should be the original sku of the product$/) do
  @product_link_shared_in_email= @inboxPrimaryTab.get_product_link_from_email
  @product_details_on_email[:sku]=@product_link_shared_in_email.split('/').last(2)[0]
  raise "Sku did not match" unless (@product_details_before_sharing[:sku]==@product_details_on_email[:sku])
  @session.driver.browser.quit
end