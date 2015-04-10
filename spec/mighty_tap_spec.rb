describe Object do
  describe "#mighty_tap" do
    let(:some_class) do
      Class.new do
        attr_accessor :state

        def initialize(initial_state = "foo")
          @state = initial_state
        end

        def state=(new_state = "bar", &block)
          @state = new_state

          if block_given?
            yield @state
          end
        end

        def upcase_state!
          @state = @state.upcase
        end
      end
    end

    it "can be used like Object#tap" do
      expect(
        some_class.new.mighty_tap do |_some_object|
          _some_object.state = "bar"
        end.state
      ).to eq("bar")
    end

    describe "it returns the object it was called on" do
      context "if a method name is given" do
        it "calls the method on the object" do
          expect(some_class.new("foo").mtap(:upcase_state!).state).to eq("FOO")
        end

        context "if arguments are given" do
          it "calls the method with the given arguments" do
            expect(some_class.new("foo").mtap(:state=, "bar").state).to eq("bar")
          end

          context "if the last argument responds to :call" do
            it "calls the method with the callable transformed into a block" do
              expect(some_class.new("foo").mtap(:state=, ->(state) { state.clear << "bar" }).state).to eq("bar")
            end
          end
        end
      end

      context "if a callable is given" do
        let(:state_changer) do
          Class.new do
            def call(object, new_state = "bar", &block)
              object.state = new_state
              yield object.state if block_given?
            end
          end.new
        end

        it "calls the callable with self" do
          expect(some_class.new("foo").mtap(state_changer).state).to eq("bar")
        end

        context "if arguments are given" do
          it "calls the callable with self and the given arguments" do
            expect(some_class.new("foo").mtap(state_changer, "muff").state).to eq("muff")
          end

          context "the last argument responds to :call" do
            it "calls the method with the callable transformed into a block" do
              expect(some_class.new("foo").mtap(state_changer, "muff", ->(state) { state.upcase! }).state).to eq("MUFF")
            end
          end
        end
      end
    end
  end
end
