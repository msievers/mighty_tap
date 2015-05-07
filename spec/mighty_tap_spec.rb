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

        protected

        def downcase_state!
          @state = @state.downcase
        end

        private

        def reset_state!
          fail NotImplementError
        end
      end
    end

    context "when used like Object#tap" do
      let(:some_object) { some_class.new }

      context "and a block is passed" do
        subject do
          some_object.mighty_tap do |_some_object|
            _some_object.state = "bar"
          end
        end

        it { is_expected.to eq(some_object) }
        its(:state) { is_expected.to eq("bar") }
      end
      context "and symbol shorthand is used" do
        subject do
          some_object.mighty_tap(&:upcase_state!)
        end

        it { is_expected.to eq(some_object) }
        its(:state) { is_expected.to eq("FOO") }
      end

      context "and protected method is called" do
        context "and a block is passed" do
          subject do
            some_object.mighty_tap do |_some_object|
              _some_object.downcase_state!
            end
          end

          it "raises NoMethodError" do
            expect { subject }.
              to raise_error(NoMethodError)
          end
        end
        context "and symbol shorthand is used" do
          subject do
            some_object.mighty_tap(&:downcase_state!)
          end

          it "raises NoMethodError" do
            expect { subject }.
              to raise_error(NoMethodError)
          end
        end
      end

      context "and private method is called" do
        context "and a block is passed" do
          subject do
            some_object.mighty_tap do |_some_object|
              _some_object.reset_state!
            end
          end

          it "raises NoMethodError" do
            expect { subject }.
              to raise_error(NoMethodError)
          end
        end
        context "and symbol shorthand is used" do
          subject do
            some_object.mighty_tap(&:reset_state!)
          end

          it "raises NoMethodError" do
            expect { subject }.
              to raise_error(NoMethodError)
          end
        end
      end
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

        context "and protected method is called" do
          subject do
            some_object.mighty_tap(:downcase_state!)
          end

          let(:some_object) { some_class.new }

          it "raises NoMethodError" do
            expect { subject }.
              to raise_error(NoMethodError)
          end
        end

        context "and private method is called" do
          subject do
            some_object.mighty_tap(:downcase_state!)
          end

          let(:some_object) { some_class.new }

          it "raises NoMethodError" do
            expect { subject }.
              to raise_error(NoMethodError)
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
