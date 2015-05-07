require "benchmark/ips"
require "mighty_tap"

class BenchmarkMightyTap
  def call
    Benchmark.ips do |x|
      x.time = 1

      x.report("[].tap(&:flatten!)") do
        [].tap(&:flatten!)
      end

      x.report("[].mtap(&:flatten!)") do
        [].mtap(&:flatten!)
      end

      x.report("[].mtap(:flatten!)") do
        [].mtap(:flatten!)
      end

      x.report("[].mtap(\"flatten!\")") do
        [].mtap("flatten!")
      end

      x.compare!
    end

    Benchmark.ips do |x|
      x.time = 1

      x.report("[].tap { |a| a.flatten!(1)") do
        [].tap { |a| a.flatten!(1) }
      end

      x.report("[].mtap { |a| a.flatten!(1)") do
        [].mtap { |a| a.flatten!(1) }
      end

      x.report("[].mtap(:flatten!, 1)") do
        [].mtap(:flatten!, 1)
      end

      x.compare!
    end
  end
end
