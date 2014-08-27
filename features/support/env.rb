require 'rubygems'
require 'bundler'
Bundler.setup(:default)
require 'capybara/cucumber'
require 'gmail'


#Increasing Selenium webdriver's default time out
Capybara.register_driver :selenium_with_long_timeout do
  client = Selenium::Driver::Remote::Http::Default.new
  client.timeout = 120
  Capybara::Selenium::Driver.new(:browser => :firefox, :http_client => client)
end

#Configuring Capybara's default driver to selenium
Capybara.default_driver = :selenium_with_long_timeout

#Configuring to run on remote server
Capybara.run_server = false

#Set locator to css
Capybara.default_selector = :css

#Set Ajax timeout
Capybara.default_wait_time=20

