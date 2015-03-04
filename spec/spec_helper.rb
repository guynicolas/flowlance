ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'vcr'
require "capybara"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true 
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.infer_spec_type_from_file_location!
end 