describe Object do
  describe "#mighty_tap" do
    it "can be used like Object#tap" do
      expect({}.mighty_tap { |_hash| _hash[:foo] = "bar" }[:foo]).to eq("bar")
    end

    context "if a method name is given" do
      describe "it calls the method on the object" do
        it "returns the object" do
          expect([[1,2,3]].mighty_tap(:flatten!)).to eq([1,2,3])
        end
      end

      context "if parameters are given" do
        describe "it calls the method on the object with the given parameters" do
          it "returns the object" do
            expect([[[1,2,3]]].mighty_tap(:flatten!, 1)).to eq([[1,2,3]])

            double_integer = -> (integer) { integer * 2 }
            expect([1,2,3].mighty_tap(:map!, double_integer)).to eq([1,2,3].map(&double_integer))
          end
        end
      end
    end

    context "if a block is given" do
      describe "calls the block with itself" do
        it "returns the object it was called on" do
          expect([[[1,2,3]]].mtap { |_array| _array.flatten!(1) }).to eq([[1,2,3]])
        end
      end
    end
  end
  
  describe "#mtap" do
    let(:object) { Object.new }

    it "is an alias for #mighty_tap" do
      expect(object.method(:mtap)).to eq(object.method(:mighty_tap))
    end
  end
end
