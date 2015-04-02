require_relative '../util/ruby_changes'

class GameManager
    #Initialize a new hash of elements and an array of producers
    def initialize(sub_managers = Hash.new(nil))
      @sub_managers = sub_managers
    end

    #Production of things
    def produce!(key, amount = 0)
      if @sub_managers[key] == nil
        raise 'Tryed to produce something which has not been added to the list of sub-managers'
      end
      @sub_managers[key].count += amount

      return self
    end

    def produce(key, amount = 0)
      return self.clone.produce!
    end

    #Use something. Returns false (and doesn't use) if the result is less than zero and true otherwise
    def use!(key, amount = 0)
        if @sub_managers[key].count >= amount
            @sub_managers[key].count -= amount
            return true
        end
        return false
    end

    def use
      result = self.clone
      result.use!
      return result
    end

    #Tick this GameManager
    def tick!
        #Cascade ticks down to subs
        @sub_managers.values.each do |sub_manager|
          sub_manager.tick self
        end
        return self
    end

    #Return a new ticked GameManager
    def tick
      return self.clone.tick!
    end

    def add_manager!(sub_manager)
      @sub_managers[sub_manager.name] = sub_manager
      return self
    end

    def add_manager(sub_manager)
      return self.clone.add_manager!(sub_manager)
    end

    def get_manager(key)
      return @sub_managers[key]
    end

    def get_subs
      return @sub_managers.clone
    end

    def log_vals
      @sub_managers.each do |key, sub_manager|
        p "There are #{sub_manager.count} of #{key}"
      end
    end

    def to_eval
      if @sub_managers.empty?
        return 'GameManager.new'
      end

      return "GameManager.new(#{@sub_managers.to_eval})"
    end

    def self.load
      return eval(saved)
    end
end
