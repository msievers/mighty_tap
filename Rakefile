require "bundler/gem_tasks"
require "rspec/core/rake_task"
require_relative "./benchmark/benchmark_mighty_tap"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :benchmark do
   BenchmarkMightyTap.new.call
end
