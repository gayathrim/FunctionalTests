require 'rubygems'
require 'bundler'
Bundler.setup(:default)
require 'capybara/cucumber'

Capybara.register_driver :selenium_with_long_timeout do
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 120
  Capybara::Selenium::Driver.new(:browser => :firefox, :http_client => client)
end

#Configuring Capybara's default driver to selenium
Capybara.default_driver = :selenium_with_long_timeout
Capybara.run_server = false

Capybara.default_selector = :css
Capybara.default_wait_time=20
