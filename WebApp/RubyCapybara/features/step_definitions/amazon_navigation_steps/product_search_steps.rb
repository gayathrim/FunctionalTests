# ---Given ---
Given(/^I login to amazon with username "([^"]*)" and password "([^"]*)"$/) do |email, password|
  @session=Capybara.current_session
  amazon_sign_in_page=SignInPage.new(@session)
  amazon_sign_in_page.goto_sign_in_page
  amazon_sign_in_page.sign_in_with_credentials(email,password)
end

#--- When ----
When(/^I search for product "([^"]*)"$/) do |product_name|
  amazon_home_page=HomePage.new(@session)
  amazon_home_page.search_for(product_name)
end

When(/^she visits the product link shared$/) do
  # @session=Capybara::Session.new(:selenium)
  @session.visit @product_link_shared_in_email
end

And(/^I select the first product$/) do
  amazon_search_page=SearchListPage.new(@session)
  amazon_search_page.select_first_product_on_list
end

And(/^I choose to share the product information by email to my friend at "([^"]*)"$/) do |email|
  amazon_product_page=ProductDescriptionPage.new(@session)
  @product_details_before_sharing=amazon_product_page.collect_product_unique_details
  email_content= amazon_product_page.share_by_email_to(email).partition("Link:")
  @product_details_before_sharing[:email_content]= email_content[0].strip
  # Defect in amazon system
  @product_details_before_sharing[:sku]=email_content[2].split('/').last
  p "Unique Product Details Collected: \n"
  p @product_details_before_sharing
end

# ---- Then ----
Then(/^she should be seeing the same product details like when I shared$/) do
  amazon_product_page=ProductDescriptionPage.new(@session)
  @product_details_on_email.merge!(amazon_product_page.collect_product_unique_details)
  raise "Product details did not match! Expected:\n #{@product_details_before_sharing} \n Email:\n #{@product_details_on_email} " unless @product_details_on_email.eql?(@product_details_before_sharing)
end