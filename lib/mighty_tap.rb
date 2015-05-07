require "mighty_tap/version"

class Object
  def mighty_tap(*args)
    if args.length > 1 && args.last.is_a?(Proc)
      method_block_proc = args.pop
    end

    if args[0].is_a?(Symbol) || args[0].is_a?(String)
      public_send(args[0], *args[1..-1], &method_block_proc)
    elsif args[0].respond_to?(:call)
      args[0].call(self, *args[1..-1], &method_block_proc)
    end

    if block_given?
      yield self
    end

    self
  end

  alias_method :mtap, :mighty_tap
end
