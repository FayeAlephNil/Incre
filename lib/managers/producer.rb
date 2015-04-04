require_relative 'sub'
require_relative 'element'

class ProducerManager < SubManager
    attr_reader :element
    attr_accessor :rate

    # Rate is how many elements will be produced per count per tick. Element is the symbol to be produced in the ElementManager.
    def initialize(element, rate, name, manager = nil, count = 0)
      super(name, 'producer', count, manager)
      @element = element
      @rate = rate
    end

    def tick(manager)
      if manager.get_subs[@element] == nil
        ElementManager.new(@element, manager, @count * @rate)
      else
        manager.produce!(@element, @count * @rate)
      end
    end

    def inspect
      return "ProducerManager.new(#{@element.inspect}, #{@rate}, #{@name.inspect}, nil, #{@count})"
    end

    alias :old_eql? :eql?

    def eql?(other)
      if @element != other.element || @rate != other.rate
        return false
      end

      return old_eql?(other)
    end
end
