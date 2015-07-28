require "yaml"
require "erb"
require "active_support/core_ext/class/attribute_accessors"

class ConfigReader

  cattr_reader :host, :username, :password, :database, :port

  def self.read
    @environment = ENV['ENV'] || "development"
    config = YAML.load ERB.new(File.read(File.join(File.dirname(__FILE__), '..', '..', 'config', 'config.yml'))).result

    @@host = config["db"][@environment]["host"]
    @@username = config["db"][@environment]["username"]
    @@password = config["db"][@environment]["password"]
    @@database = config["db"][@environment]["database"]
    @@port= config["db"][@environment]["port"]
  end
end