require "mighty_tap/version"

class Object
  def mighty_tap(*args, &block)
    if args.length == 1
      self.send(args[0])
    elsif args.length == 2
      if args[1].is_a?(Proc)
        # this assumption might be wrong for some edge cases but
        # in almost all other cases it should be the right decision
        self.send(args[0], &args[1])
      else
        self.send(args[0], args[1])
      end
    elsif args.length > 2
      self.send(args[0], *args[1..-1])
    end

    if block_given?
      yield self
    end

    self
  end

  alias_method :mtap, :mighty_tap
end
