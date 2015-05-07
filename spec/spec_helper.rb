if ENV["CODECLIMATE_REPO_TOKEN"]
  # report coverage only for latest mri ruby
  if RUBY_ENGINE == "ruby" && RUBY_VERSION >= "2.2.0"
    require "codeclimate-test-reporter"
    CodeClimate::TestReporter.start
  end
else
  require "simplecov"
  SimpleCov.start
end

begin
  require "pry"
rescue LoadError
end

require "mighty_tap"

RSpec.configure do |config|
  # begin --- rspec 3.1 generator
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  # end --- rspec 3.1 generator
end
