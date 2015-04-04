require_relative 'sub'
require_relative 'element'

class ProducerManager < SubManager
    attr_accessor :rates

    # Rate is how many elements will be produced per count per tick. Element is the symbol to be produced in the ElementManager.
    def initialize(rates, name, manager = nil, count = 0)
      super(name, 'producer', count, manager)
      @rates = rates
    end

    def tick(manager)
      @rates.each do |element, rate|
        if manager.get_subs[element] == nil
          ElementManager.new(element, manager, @count * rate)
        else
          manager.produce!(element, @count * rate)
        end
      end
    end

    def inspect
      return "ProducerManager.new(#{@rate.inspect}, #{@name.inspect}, nil, #{@count})"
    end

    alias :old_eql? :eql?

    def eql?(other)
      if @rates != other.rates
        return false
      end

      return old_eql?(other)
    end
end
