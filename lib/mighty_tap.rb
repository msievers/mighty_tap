require "mighty_tap/version"

class Object
  def mighty_tap(*args, &block)
    if args.empty?
      tap(&block)
    else
      if args.length == 1
        self.send(args[0])
      elsif args.length == 2 && args[1].is_a?(Proc)
        # this assumption might be wrong for some edge cases but
        # in almost all other cases it should be the right decision
        self.send(args[0], &args[1])
      else
        self.send(args[0], *args[1..-1])
      end

      self
    end
  end

  alias_method :mtap, :mighty_tap
end
