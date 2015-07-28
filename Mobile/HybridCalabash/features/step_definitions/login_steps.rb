Given /^I am on home page after login with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  step %Q{I am on the login page}
  step %Q{I sign in with username "#{username}" and password "#{password}"}
  step %Q{I should be landed on home page}
end

Then /^I should see Welcome screen with Sign in button and store info link$/ do
  @page=WelcomePage.new
  @page.verify_welcome_page_elements
end

Then /^I should see login page with title Login and Username and Password fields$/ do
  @page=LoginPage.new
  @page.verify_login_page_elements()
end

Then /^I should see placeholder text in username and password fields$/ do
  @page.verify_username_has_placeholder("Utente")
  @page.verify_password_has_placeholder("Password")
end

Then /^I navigate to login page$/ do
  @page.navigate_to_login_page
end

Given /^I am on the login page$/ do
  step %Q{I should see Welcome screen with Sign in button and store info link}
  step %Q{I navigate to login page}
  #if(ENV['PLATFORM'] == 'ios')
    step %Q{I should see terms and conditions page}
    step %Q{I agree terms and conditions}
  #end
  step %Q{I should see login page with title Login and Username and Password fields}
end

When /^I sign in with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  @page.enter_user_credentials(username, password)
  @page.click_login
end

Then /^I should see terms and conditions page$/ do
  @page=TermsAndConditionsPage.new
  @page.verify_tnc_page_elements()
end

When /^I agree terms and conditions$/ do
  @page.accept_terms_and_conditions()
  @page=LoginPage.new
end

Then /^I touch logout$/ do
  @page.logout()
  @page.touch_ok_on_popup
  @page.wait_for_error_popup_to_dismiss
  @page=WelcomePage.new
end

Then /^I should see have information displayed to register online$/ do
  @page.verify_register_online_text
end

When /^I touch Accedi link for the first time$/ do
  @page.navigate_to_login_page
  @page=TermsAndConditionsPage.new
end

Given /^I am on the login page after accepting terms and conditions$/ do
  step %Q{I should see Welcome screen with Sign in button and store info link}
  step %Q{I navigate to login page}
  step %Q{I should see terms and conditions page}
  step %Q{I agree terms and conditions}
  step %Q{I should see login page with title Login and Username and Password fields}
end

Then /^I am on home page after login with username "([^"]*)" and password "([^"]*)" without TnC$/ do |username, password|
  step %Q{I should see Welcome screen with Sign in button and store info link}
  step %Q{I navigate to login page}
  step %Q{I should see login page with title Login and Username and Password fields}
  step %Q{I sign in with username "#{username}" and password "#{password}"}
  step %Q{I should be landed on home page}
end
