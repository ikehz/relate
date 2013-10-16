ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.expand_path(File.dirname(__FILE__) + '/blueprints')

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  include Grant::Status

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #
  # Do not use fixtures; we're using Machinist instead
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end
