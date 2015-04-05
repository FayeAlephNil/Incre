require_relative 'sub'
require_relative 'element'

class ProducerManager < SubManager
    attr_accessor :rates

    # Rate is how many elements will be produced per count per tick. Element is the symbol to be produced in the ElementManager.
    def initialize(rates, name, manager = nil, count = 0)
      super(name, 'producer', count, manager)
      @rates = rates
    end

    # Produces the elements at the rates defined in @rates.
    def tick(manager)
      # For each element/rate pair produce the element
      @rates.each do |element, rate|
          manager.produce!(element, @count * rate, ElementManager.new(element))
      end
    end

    # Returns valid ruby to create a new copy of this with the same vars
    def inspect
      return "ProducerManager.new(#{@rates.inspect}, #{@name.inspect}, nil, #{@count})"
    end

    alias :old_eql? :eql?

    # equality test
    def eql?(other)
      # Check if the rates aren't equal
      if @rates != other.rates
        return false
      end

      # Use the equal from SubManager to check
      return old_eql?(other)
    end
end
