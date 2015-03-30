class ProducerManager
    attr_reader :element
    attr_accessor :count
    attr_accessor :rate

    # Rate is how many elements will be produced per count per tick. Element is the symbol to be produced in the ElementManager.
    def initialize(element, rate, count = 0, manager = nil)
        @count = count
        @element = element
        @rate = rate
        if manager != nil then manager.producers << self end
    end

    def tick(manager)
      manager.produce(@element, @count * @rate)
    end
end
