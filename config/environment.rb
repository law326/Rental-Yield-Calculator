# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'net/http' if ENV['OS'] == 'Windows_NT'

# Initialize the Rails application.
Rentify::Application.initialize!
