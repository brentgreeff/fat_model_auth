# frozen_string_literal: true

require 'bundler/setup'
require 'ostruct'
require 'active_record'
require 'models/application_record'
require 'init_schema'

require 'fat_model_auth/gate_keeper'
require 'fat_model_auth/model_helpers'

ActiveSupport.on_load(:active_record) { extend FatModelAuth::ModelHelpers }
ActiveSupport.run_load_hooks(:active_record, ActiveRecord::Base)

require 'models/article'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
end
