#--- Given ---
Given(/^my friend logins to her gmail with username "([^"]*)" and password "([^"]*)"$/) do |email, password|
  p "Logging into gmail"
  Gmail.new(email,password) do |gmail|
    @amazon_emails= gmail.inbox.emails(:unread, :on => Date.today, :from => "no-reply@amazon.com")
    @wait_time=10
    until (!@amazon_emails.nil?)|(@wait_time==0)
      @amazon_emails= gmail.inbox.emails(:unread, :on => Date.today, :from => "no-reply@amazon.com")
      @wait_time=@wait_time-2
      p "Waiting for email..."
    end
    raise "Email from amazon did not reach the user" if @amazon_emails.nil?
  end
end

#---- When -----
When(/^she opens my email$/) do
  latest_email=@amazon_emails.last
  p latest_email
  charset = latest_email.text_part.content_type_parameters[:charset]
  body =latest_email.text_part.body.to_s.force_encoding(charset).encode("UTF-8")
  body=body.split("\n").collect{|element| element.strip}
  body.delete_if{|element| element.empty? }
  p "Email content:\n"
  p body

  @product_details_on_email=Hash.new
  @product_details_on_email[:email_content]=body[1]+body[2]
  @product_link_shared_in_email=body[4]
  @product_details_on_email[:sku]=@product_link_shared_in_email.split('/').last(2)[0]
end

#---- Then------
Then(/^she should be seeing the same email content as sent from amazon$/) do
  raise "Email content did not match. Expected: '#{@product_details_before_sharing[:email_content]}' Got: '#{@product_details_on_email[:email_content]}'" unless (@product_details_before_sharing[:email_content]==@product_details_on_email[:email_content])
end

And(/^the sku of the product shared in the link should be the original sku of the product$/) do
  raise "Sku did not match. Expected: '#{@product_details_before_sharing[:sku]}'. Got: '#{@product_details_on_email[:sku]}'" unless (@product_details_before_sharing[:sku]==@product_details_on_email[:sku])
  # @session.driver.browser.quit
end