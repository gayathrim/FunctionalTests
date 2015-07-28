require 'rubygems'
require 'bundler'
require 'capybara/cucumber'
require 'gmail'


#Configuring Capybara's default driver to selenium
Capybara.default_driver = :selenium

#Configuring to run on remote server
Capybara.run_server = false

#Set locator to css
Capybara.default_selector = :css

#Set Ajax timeout
Capybara.default_wait_time=20

