class ElementsManager
    #Allow access so that ProducerManagers can add themselves
    attr_accessor :producers

    #Initialize a new hash of elements and an array of producers
    def initialize(elements = Hash.new(-1), producers = Hash.new(ProducerManager.new('null', 0, 'null', 0)))
        @elements = elements
        @producers = producers
    end

    #Production of things
    def produce_element(key, amount = 0)
      if @elements[key] == -1 then @elements[key] = 0 end
      @elements[key] += amount
    end

    def produce_producer(key, amount = 0)
      if @producers[key] != ProducerManager.new('null', 0, 'null', 0, self)
        @producers[key].count += amount
      else
        raise "Tryed to add to the count of a null ProducerManager"
      end
    end

    def produce_general(key, amount = 0)
      if @producers[key] != ProducerManager.new('null', 0, 'null', 0, self)
        produce_producer key, amount
      elsif @elements[key] != -1
        produce_element key, amount
      end
    end

    #Use some of the elements. Returns false if the result is less than zero and true otherwise
    def use(key, amount = 0)
        if @elements[key] >= amount
            @elements[key] -= amount
            return true
        end
        return false
    end

    #Returns the element count for key
    def get_element(key)
      @elements[key]
    end

    def get_elements
      @elements.keys
    end

    #Tick this ElementsManager
    def tick
        #Cascade ticks down to producers
        @producers.values.each do |producer|
            producer.tick self
        end
    end
    
    def log_vals
        @producers.each do |key, producer|
            p "There are #{producer.count} #{key}"
        end
        
        @elements.each do |key, count|
           p "There are #{count} of #{key} element(s)" 
        end
    end
end
