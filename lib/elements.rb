class ElementsManager
    #Allow access so that ProducerManagers can add themselves
    attr_accessor :producers

    #Initialize a new hash of elements and an array of producers
    def initialize(elements = Hash.new(0), producers = [])
        @elements = elements
        @producers = producers
    end

    #Produce some elements
    def produce(key, amount = 0)
       @elements[key] += amount
    end

    #Use some of the elements. Returns false if the result is less than zero and true otherwise
    def use(key, amount = 0)
        if @elements[key] >= amount then
            @elements[key] -= amount
            return true
        end
        return false
    end

    #Returns the element count for key
    def getElement(key)
      @elements[key]
    end

    def getElements
      @elements.keys
    end

    #Tick this ElementsManager
    def tick
        #Cascade ticks down to producers
        producers.each do |producer|
            producer.tick self
        end
    end
end
