require "benchmark/ips"
require "mighty_tap"

class BenchmarkMightyTap
  def call
    array = [1,2,3,4]

    Benchmark.ips do |x|
      x.report("map!") do
        array.mtap(:map!) do |_item|
          _item * 2
        end
      end

      x.compare!
    end
  end
end

BenchmarkMightyTap.new.call
