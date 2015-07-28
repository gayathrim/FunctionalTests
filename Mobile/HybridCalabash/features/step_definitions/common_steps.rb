Given /^I am at latitude "([^"]*)" and longitude "([^"]*)"$/ do |latitude, longitude|
  @page=CommonPage.new
  @page.set_geo_coordinates(latitude,longitude)
end

When /^I touch Back button$/ do
  @page= @page.go_back
end

Then /^I should be landed on home page$/ do
  @page=HomePage.new
  @page.verify_home_page_elements()
end

Given /^that I am on Welcome screen$/ do
  step %Q{I should see Welcome screen with Sign in button and store info link}
end

Then /^I should see error message "([^"]*)"$/ do |error_msg|
  @page.wait_for_loading_icon_to_disappear
  @page.verify_error_msg_in_popup(error_msg)
  @page.touch_ok_on_popup
  @page.wait_for_error_popup_to_dismiss
end

When /^I reopen my app$/ do
  start_test_server_in_background
  sleep(20)
end

Then /^swipe till I see "([^"]*)"$/ do |text|
  @page.scroll_till_I_find(text)
end

Then /^verify the last updated date is set to "([^"]*)"$/ do |date|
  expected_date=@page.get_chronic_parsed_date(date)
  @page.verify_last_updated_date(expected_date)
end

Then /^I touch refresh button$/ do
  @page.click_refresh
  @page.wait_for_loading_icon_to_disappear
end

Then /^I should see inline error message "([^"]*)"$/ do |err_msg|
  @page.wait_for_card_list_page_to_load
  @page.verify_inline_error_msg(err_msg)
end