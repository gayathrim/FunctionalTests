require 'rubygems'
require 'bundler'
require 'chronic'
require 'active_record'

if ENV['PLATFORM'] == 'ios'
  require 'calabash-cucumber/cucumber'
  require 'calabash-cucumber/calabash_steps'
  require 'calabash-cucumber/core.rb'
  require 'calabash-cucumber/location.rb'
elsif ENV['PLATFORM'] == 'android'
  require 'calabash-android/cucumber'
  require 'calabash-android'
  require 'calabash-android/calabash_steps'
  require 'calabash-android/operations'
end

require File.join(File.dirname(__FILE__),'config_reader')
ConfigReader.read


