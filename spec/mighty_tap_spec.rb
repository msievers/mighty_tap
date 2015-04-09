describe Object do
  describe "#mighty_tap" do
    let(:some_hash) { {} }

    it "can be used like Object#tap" do
      expect({}.mighty_tap { |_hash| _hash[:foo] = "bar" }[:foo]).to eq("bar")
    end

    context "if a method name is given" do
      let(:array) { [1,2,3] }
      let(:nested_array) { [array] }
      let(:deeply_nested_array) { [nested_array] }

      describe "it calls the method on the object" do
        it "returns the object" do
          expect(nested_array.mighty_tap(:flatten!)).to eq(array)
        end
      end

      context "if parameters are given" do
        describe "it calls the method on the object with the given parameters" do
          it "returns the object" do
            double_integer = -> (integer) { integer * 2 }

            expect(deeply_nested_array.mighty_tap(:flatten!, 1)).to eq(nested_array)
            expect(array.dup.mighty_tap(:map!, double_integer)).to eq(array.map(&double_integer))
          end
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
