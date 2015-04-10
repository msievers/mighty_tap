source "https://rubygems.org"

# Specify your gem's dependencies in your gemspec
gemspec

if !ENV["CI"]
  group :development do
    gem "pry",                "~> 0.9.12.6"
    gem "pry-rescue",         "~> 1.4.1"
    gem "pry-syntax-hacks",   "~> 0.0.6"

    if RUBY_ENGINE == "ruby"
      gem "pry-byebug",         "<= 1.3.2"
      gem "pry-stack_explorer", "~> 0.4.9.1"
    else
      # gem "pry-nav"
    end
  end
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end
