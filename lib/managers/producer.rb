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
      if manager.sub_managers[@element] == nil
        ElementManager.new(@element, manager, @count * @rate)
      else
        manager.produce!(@element, @count * @rate)
      end
    end

    def to_eval
      return "ProducerManager.new(#{@element.to_eval}, #{@rate}, #{@name.to_eval}, nil, #{@count})"
    end
end
